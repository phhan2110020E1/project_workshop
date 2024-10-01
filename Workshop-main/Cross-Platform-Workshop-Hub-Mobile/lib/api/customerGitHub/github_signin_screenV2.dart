// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workshop_mobi/api/customerGitHub/constsv2.dart';
import 'package:workshop_mobi/api/customerGitHub/gitHub_SignIn_ParamsV2.dart';
import 'package:workshop_mobi/api/customerGitHub/github_signin_responseV2.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GithubSigninScreenV2 extends StatefulWidget {
  /// the [headerColor] of the [AppBar]
  final Color? headerColor;

  /// the [headerTextColor] of the [AppBar]
  final Color? headerTextColor;

  /// flag to enable or [SafeArea] top
  final bool? safeAreaTop;

  /// flag to enable or [SafeArea] bottom
  final bool? safeAreaBottom;

  /// the [title] of the [AppBar]
  final String? title;

  /// the required [GithubSignInParams] [params]
  final GithubSignInParamsV2 params;

  const GithubSigninScreenV2({
    super.key,
    required this.params,
    this.headerColor = Colors.blue,
    this.headerTextColor = Colors.white,
    this.safeAreaTop = false,
    this.safeAreaBottom = false,
    this.title = 'Github SignIn',
  });

  @override
  State<GithubSigninScreenV2> createState() => _GithubSigninScreenV2State();
}

class _GithubSigninScreenV2State extends State<GithubSigninScreenV2> {
  //endregion

  /// flag to display the progressbar
  bool shouldShowLoading = false;

  /// the controller of [InAppWebViewController]
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: widget.safeAreaTop ?? false,
      bottom: widget.safeAreaBottom ?? false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.title}',
            style: TextStyle(
              color: widget.headerTextColor,
            ),
          ),
          backgroundColor: widget.headerColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: widget.headerTextColor),
            onPressed: () {
              GithubSignInResponseV2 res = GithubSignInResponseV2(
                status: SignInStatusV2.failed,
                error: 'User cancelled',
              );
              Navigator.of(context).pop(res);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    onWebViewCreated: (c) {
                      onWebViewCreated(c);
                    },
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                          useShouldOverrideUrlLoading: true,
                          cacheEnabled: true,
                          clearCache: true,
                          transparentBackground: true),
                    ),
                    onProgressChanged: (_, p) {
                      onProgressChanged(p);
                    },
                    shouldOverrideUrlLoading: (x, navigationAction) async {
                      try {
                        bool startWithRedirectUrl = navigationAction.request.url
                                .toString()
                                .startsWith(widget.params.redirectUrl) ==
                            true;
                        bool hasCodeParam =
                            Uri.parse(navigationAction.request.url.toString())
                                    .queryParameters['code'] !=
                                null;

                        if (hasCodeParam && startWithRedirectUrl) {
                          handleCodeResponse(navigationAction, context);
                          return NavigationActionPolicy.CANCEL;
                        } else {
                          return NavigationActionPolicy.ALLOW;
                        }
                      } catch (e) {
                        return NavigationActionPolicy.ALLOW;
                      }
                    },
                  ),
                  _buildProgressbar(),
                ],
              ),
            ),
            //endregion
          ],
        ),
      ),
    );
  }

  /// try to get token from github then navigate to previous screen by [Navigator.of(context).pop(value)]
  void handleCodeResponse(
      NavigationAction navigationAction, BuildContext context) {
    var callBackCode = Uri.parse(navigationAction.request.url.toString())
        .queryParameters['code'];

    handleResponse(callBackCode).then((value) {
      Navigator.of(context).pop(value);
    }).catchError((onError) {
      GithubSignInResponseV2 res = GithubSignInResponseV2(
        status: SignInStatusV2.failed,
        error: onError.toString(),
      );
      Navigator.of(context).pop(res);
    });
  }

  void onWebViewCreated(InAppWebViewController c) {
    webViewController = c;
    webViewController.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(widget.params.combinedUrl()),
      ),
    );
  }

  Widget _buildProgressbar() {
    if (shouldShowLoading) {
      return LinearProgressIndicator(
        color: widget.headerColor,
      );
    }
    return Container();
  }

  void onProgressChanged(int p) {
    setState(() {
      shouldShowLoading = p != 100;
    });
  }

  /// Call api and get the access token from github
  Future<GithubSignInResponseV2> handleResponse(String? code) async {
  try {
    // First, get the access token
    var response = await http.post(
      Uri.parse(getAccesTokenUrl),
      headers: {"Accept": "application/json"},
      body: {
        "client_id": widget.params.clientId,
        "client_secret": widget.params.clientSecret,
        "code": code
      },
    );

    var accessToken = json.decode(response.body)['access_token'];

    // Get user data using the obtained access token
    var userResponse = await http.get(
      Uri.parse('https://api.github.com/user'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    var avatarUrl = '';
    var name = '';
    var email = '';

    // Check if the request for user data was successful
    if (userResponse.statusCode == 200) {
      var userData = json.decode(userResponse.body);
      avatarUrl = userData['avatar_url'];
      name = userData['login'];
    } else {
      print('Failed to fetch user data. Status code: ${userResponse.statusCode}');
    }

    // Now, get the list of email addresses associated with the GitHub account
    var emailListResponse = await http.get(
      Uri.parse('https://api.github.com/user/emails'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    // Check if the request for email addresses was successful
    if (emailListResponse.statusCode == 200) {
      var emailList = json.decode(emailListResponse.body);
      // Assuming the first email in the list is the primary email
      if (emailList.isNotEmpty) {
        email = emailList[0]['email'];
      }
    } else {
      print('Failed to fetch email addresses. Status code: ${emailListResponse.statusCode}');
    }

    var body = json.decode(utf8.decode(response.bodyBytes));
    bool hasError = body['error'] != null;

    // Handle error case
    if (hasError) {
      String errorDetail = body['error_description'] ?? 'Unknown Error: ${body.toString()}';
      GithubSignInResponseV2 res = GithubSignInResponseV2(
        status: SignInStatusV2.failed,
        error: errorDetail,
      );
      return res;
    }

    // Handle success case
    return GithubSignInResponseV2(
      status: SignInStatusV2.success,
      accessToken: '${body['access_token']}',
      email: email,
      picture: avatarUrl,
      name: name,
    );
  } catch (e) {
    return GithubSignInResponseV2(
        status: SignInStatusV2.failed, error: 'Error: ${e.toString()}');
  }
}

}

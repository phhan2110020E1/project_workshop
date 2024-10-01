// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:workshop_mobi/api/customerGitHub/gitHub_SignIn_ParamsV2.dart';
import 'package:workshop_mobi/api/customerGitHub/github_signin_responseV2.dart';
import 'package:workshop_mobi/api/customerGitHub/github_signin_screenV2.dart';

class GitHubSignInApi {
  static Future<Map<String, dynamic>> login(BuildContext context) async {
    final params = GithubSignInParamsV2(
      clientId: '13834b566cdff854a8a4',
      clientSecret: 'dc64f118e65380062195af2018233733ab5ccf8d',
      redirectUrl: 'http://localhost:3000/auth/github/callback',
      scopes: 'read:user,user:email',
    );
    try {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return GithubSigninScreenV2(
            params: params,
          );
        }),
      );
      print(result);
      if (result is GithubSignInResponseV2) {
        return {
          'status': result.status,
          'accessToken': result.accessToken,
          'error': result.error,
          'email': result.email,
          'name': result.name,
          'picture': result.picture,
        };
      } else {
        return {
          'error': 'Login failed or canceled.',
        };
      }
    } catch (e) {
      return {
        'error': 'An error occurred during login: $e',
      };
    }
  }
}

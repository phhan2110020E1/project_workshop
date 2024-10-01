// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInApi {
  static Future<Map<String, dynamic>?> login() async {
    // ignore: unused_local_variable
    AccessToken? _accessToken;
    // ignore: unused_local_variable
    Map<String, dynamic>? _userData;
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } else {
      print(result);
      print(result.message);
    }
    return _userData;
  }
}

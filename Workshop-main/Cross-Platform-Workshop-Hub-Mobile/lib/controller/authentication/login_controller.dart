// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/api/facebook_sigin_api.dart';
import 'package:workshop_mobi/api/github_sigin_api.dart';
import 'package:workshop_mobi/api/google_signin_api.dart';
import 'package:workshop_mobi/screens/teacherLayout/teacher_home.dart';
import 'package:workshop_mobi/screens/userLayout/user_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController extends GetxController {
  final ApiService apiService = ApiService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxString imageUrl = "".obs;
  RxString? image0AuthenUrl = "".obs;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> loginWithEmail() async {
    try {
      var user = await apiService.loginWebAccount(
        emailController.text.trim(),
        passwordController.text,
      );
      final SharedPreferences prefs = await _prefs;
      var roles = user['roles'];

      String roleString = '';
      if (roles != null && roles.isNotEmpty) {
        roleString = roles[0];
      } else {}

      var accessToken = user['accessToken'];
      var userName = user['user_name'];

      // imageUrl.value = user['image'];
      await prefs.setString('token', accessToken);

      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: accessToken);
      await storage.write(key: 'roles', value: roleString);
      await storage.write(key: 'userName', value: userName);
      var email = user['email'];
      await storage.write(key: 'email', value: email);
      emailController.clear();

      passwordController.clear();
      if (roleString == 'USER') {
        Get.off(const UserHomeScreen());
      } else if (roleString == 'SELLER') {
        Get.off(const TeacherHomeScreen());
      } else if (roleString == 'ADMIN') {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.no_accounts,
                      color: Colors.redAccent), // Updated icon
                  SizedBox(width: 17),
                  Expanded(
                    // Wrap Text in Expanded to avoid overflow
                    child: Text(
                      'Access Denied',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16, // Adjust font size as needed
                      ),
                      overflow: TextOverflow.ellipsis, // Prevents text wrapping
                    ),
                  ),
                ],
              ),
              content: Text(
                'Admin cant not login product app',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK', style: TextStyle(color: Colors.blueAccent)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: Colors.white,
            );
          },
        );
      }
    } catch (error) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: const [
                Icon(Icons.error_outline, color: Colors.red),
                SizedBox(width: 10),
                Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            content: const Text(
              'Your Account Not Available for this App, Please Register First',
              style: TextStyle(fontSize: 16),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: Colors.white,
          );
        },
      );
    }
  }

  Future<void> loginWithGoogle() async {
    final user = await GoogleSignInApi.login();
    String? email = user?.email;
    try {
      var user = await apiService.login0AuthenAccount(
        email!,
      );
      final SharedPreferences prefs = await _prefs;
      var roles = user['roles'];

      String roleString = '';
      if (roles != null && roles.isNotEmpty) {
        roleString = roles[0];
      } else {}

      var accessToken = user['accessToken'];
      var userName = user['user_name'];

      await prefs.setString('token', accessToken);
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: accessToken);
      await storage.write(key: 'roles', value: roleString);
      await storage.write(key: 'userName', value: userName);
      var emails = user['email'];
      await storage.write(key: 'email', value: emails);
      emailController.clear();
      passwordController.clear();
      if (roleString == 'USER') {
        Get.off(const UserHomeScreen());
      } else if (roleString == 'SELLER') {
        Get.off(const TeacherHomeScreen());
      } else if (roleString == 'ADMIN') {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return const SimpleDialog(
              title: Text('False'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('ADMIN CAN NOT LOGIN PRODUCT APP')],
            );
          },
        );
      }
    } catch (error) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return const SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [
              Text(
                  'Your Account Not Available for this App, Please Register First')
            ],
          );
        },
      );
    }
  }

  Future<void> loginWithFacebook() async {
    final user = await FacebookSignInApi.login();

    String? email = user?['email'];

    try {
      var user = await apiService.login0AuthenAccount(
        email!,
      );
      print(user);
      final SharedPreferences prefs = await _prefs;
      var roles = user['roles'];
      const storage = FlutterSecureStorage();
      String roleString = '';
      if (roles != null && roles.isNotEmpty) {
        roleString = roles[0];
      } else {}
      var accessToken = user['accessToken'];
      var userName = user['user_name'];

      await prefs.setString('token', accessToken);
      await storage.write(key: 'token', value: accessToken);
      await storage.write(key: 'roles', value: roleString);
      await storage.write(key: 'userName', value: userName);
      var emails = user['email'];
      await storage.write(key: 'email', value: emails);
      emailController.clear();
      passwordController.clear();
      if (roleString == 'USER') {
        Get.off(const UserHomeScreen());
      } else if (roleString == 'SELLER') {
        Get.off(const TeacherHomeScreen());
      } else if (roleString == 'ADMIN') {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return const SimpleDialog(
              title: Text('False'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('ADMIN CAN NOT LOGIN PRODUCT APP')],
            );
          },
        );
      }
    } catch (error) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return const SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [
              Text(
                  'Your Account Not Available for this App, Please Register First')
            ],
          );
        },
      );
    }
  }

  Future<void> loginWithGitHub(BuildContext context) async {
    final oauthClient = await GitHubSignInApi.login(context);
    String? email = (oauthClient['email']);
    try {
      var user = await apiService.login0AuthenAccount(
        email!,
      );
      print(user);
      final SharedPreferences prefs = await _prefs;
      var roles = user['roles'];
      const storage = FlutterSecureStorage();
      String roleString = '';
      if (roles != null && roles.isNotEmpty) {
        roleString = roles[0];
      } else {}
      var accessToken = user['accessToken'];
      var userName = user['user_name'];
      var emails = user['email'];
      await storage.write(key: 'email', value: emails);
      await prefs.setString('token', accessToken);
      await storage.write(key: 'token', value: accessToken);
      await storage.write(key: 'roles', value: roleString);
      await storage.write(key: 'userName', value: userName);
      emailController.clear();
      passwordController.clear();
      if (roleString == 'USER') {
        Get.off(const UserHomeScreen());
      } else if (roleString == 'SELLER') {
        Get.off(const TeacherHomeScreen());
      } else if (roleString == 'ADMIN') {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return const SimpleDialog(
              title: Text('False'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('ADMIN CAN NOT LOGIN PRODUCT APP')],
            );
          },
        );
      }
    } catch (error) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return const SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [
              Text(
                  'Your Account Not Available for this App, Please Register First')
            ],
          );
        },
      );
    }
  }
}

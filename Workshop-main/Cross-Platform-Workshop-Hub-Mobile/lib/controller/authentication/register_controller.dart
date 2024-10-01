import 'package:get/get.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  var isPasswordVisible = false.obs;
  final ApiService apiService = ApiService();
  TextEditingController emailController = TextEditingController();
  TextEditingController configEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController configPasswordController = TextEditingController();

  bool isSeller = false;
  String role = '';
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // ignore: non_constant_identifier_names
  Future<void> RegisterUserAsyn() async {
    if (isSeller) {
      role = "SELLER";
    } else {
      role = "USER";
    }
    try {
      var responese = await apiService.registerAccount(
        emailController.text.trim(),
        passwordController.text.trim(),
        role,
      );
      if (emailController != '' && emailController != null) 
      {
        
      }
      if (responese['status'] == 'Success') {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text(responese['status']),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(responese['message'])],
            );
          },
        );
      } else if (responese['status'] == 'failed') {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text(responese['status']),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(responese['message'])],
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
            children: [Text('SignUp Error, please check again')],
          );
        },
      );
    }
  }
}

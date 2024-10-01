import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_mobi/controller/authentication/register_controller.dart';

import 'package:workshop_mobi/screens/auth/components/my_button.dart';
import 'package:workshop_mobi/screens/auth/components/my_email_textfield.dart';
import 'package:workshop_mobi/screens/auth/components/my_emailconfirm_textfield.dart';
import 'package:workshop_mobi/screens/auth/components/my_pw_textfield.dart';
import 'package:workshop_mobi/screens/auth/components/my_pwconfirm_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> emailformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> configemailformKeyformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> configpasswordformKey = GlobalKey<FormState>();

  RegisterController registerController = Get.put(RegisterController());
  void _showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool isLoading = false; // New variable to track loading state
  bool _validateForm() {
    bool isValid = true;
    if (!emailformKey.currentState!.validate()) {
      isValid = false;
    }
    if (!configemailformKeyformKey.currentState!.validate()) {
      isValid = false;
    }
    if (!passwordformKey.currentState!.validate()) {
      isValid = false;
    }
    if (!configpasswordformKey.currentState!.validate()) {
      isValid = false;
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  MyEmailTextfield(
                    obscureText: false,
                    controller: registerController.emailController,
                    formKey: emailformKey,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  MyConfirmEmailTextfield(
                    formKey: configemailformKeyformKey,
                    emailController: registerController.emailController,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  MyPwTextfield(
                    obscureText: true,
                    controller: registerController.passwordController,
                    formKey: passwordformKey,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  MyConfirmPwTextfield(
                    formKey: configpasswordformKey,
                    passwordController: registerController.passwordController,
                    configpasswordController:
                        registerController.configPasswordController,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "I am a Workshop Leader",
                        style: TextStyle(color: Colors.black),
                      ),
                      Switch(
                        value: registerController.isSeller,
                        onChanged: (bool newValue) {
                          setState(() {
                            registerController.isSeller = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  MyButton(
                    text: isLoading ? 'Registering....' : 'Register',
                    onTap: () async {
                      if (_validateForm()) {
                        setState(() {
                          isLoading = true; // Start loading
                        });
                        try {
                          await registerController.RegisterUserAsyn();
                        } finally {
                           setState(() {
                          isLoading = false; // Start loading
                        });
                        }
                      } else {
                        _showErrorMessage('Please fill all fields correctly');
                      }
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login here",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00AEEF),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

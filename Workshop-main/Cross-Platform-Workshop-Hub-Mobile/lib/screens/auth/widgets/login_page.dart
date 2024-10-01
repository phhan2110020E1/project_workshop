import 'package:flutter/material.dart';
import 'package:workshop_mobi/controller/authentication/login_controller.dart';
import 'package:workshop_mobi/screens/auth/components/my_button.dart';
import 'package:workshop_mobi/screens/auth/components/my_pw_textfield.dart';
import 'package:workshop_mobi/screens/auth/components/my_email_textfield.dart';
import 'package:get/get.dart';
import 'package:workshop_mobi/screens/auth/widgets/forgot_password.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final void Function()? onTap;

  // ignore: use_key_in_widget_constructors
  LoginPage({Key? key, required this.onTap});

  LoginController loginController = Get.put(LoginController());

  final GlobalKey<FormState> emailformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.1), // Adjust padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: screenHeight * 0.05,
                      fontWeight: FontWeight.w700), // Adjust font size
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                MyEmailTextfield(
                  obscureText: false,
                  controller: loginController.emailController,
                  formKey: emailformKey,
                ),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                MyPwTextfield(
                  controller: loginController.passwordController,
                  formKey: passwordformKey,
                  obscureText: true,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(onTap: () {}),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot password?",
                        // ignore: unnecessary_const
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00AEEF),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                MyButton(
                  text: 'Sign in',
                  onTap: () async {
                    await loginController.loginWithEmail();
                  },
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        "Register here",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00AEEF)),
                      ),
                    ),
                  ],
                ),
                // Nút đăng nhập bằng Facebook
                SignInButton(
                  Buttons.Google,
                  onPressed: ()  {
                      loginController.loginWithGoogle();
                  },
                ),

                // Nút đăng nhập bằng GitHub
                SignInButton(
                  Buttons.GitHub,
                  onPressed: () {
                    loginController.loginWithGitHub(context);
                  },
                ),

                // Nút đăng nhập bằng Facebook
                SignInButton(
                  Buttons.Facebook,
                  onPressed: () {
                   loginController.loginWithFacebook() ;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

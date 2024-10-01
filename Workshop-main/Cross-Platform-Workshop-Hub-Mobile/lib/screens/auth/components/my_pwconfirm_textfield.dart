import 'package:flutter/material.dart';
class MyConfirmPwTextfield extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
final TextEditingController configpasswordController;
  const MyConfirmPwTextfield(
      {Key? key, required this.formKey, required this.passwordController, required this.configpasswordController})
      : super(key: key);
  @override
  State<MyConfirmPwTextfield> createState() => _MyConfirmPwTextfieldState();
}
class _MyConfirmPwTextfieldState extends State<MyConfirmPwTextfield> {
  bool obscureText = true;
  String? _validatePasswordConfirmation(String? value) {
    final String password = widget.passwordController.text;
    // ignore: unnecessary_null_comparison
    if (widget.passwordController.text == null) {
      return 'Password is null';
    } else {}
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        obscureText: obscureText,
      controller: widget.configpasswordController,
        decoration: InputDecoration(
          labelText: 'Confirm password',
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        validator: _validatePasswordConfirmation,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

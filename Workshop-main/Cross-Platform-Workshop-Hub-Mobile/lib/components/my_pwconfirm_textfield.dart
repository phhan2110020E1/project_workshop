import 'package:flutter/material.dart';

class MyConfirmPwTextfield extends StatefulWidget {
  final TextEditingController controller;

  const MyConfirmPwTextfield({super.key, required this.controller});

  @override
  State<MyConfirmPwTextfield> createState() => _MyConfirmPwTextfieldState();
}

class _MyConfirmPwTextfieldState extends State<MyConfirmPwTextfield> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: widget.controller,
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
    );
  }
}

import 'package:flutter/material.dart';

class MyConfirmEmailTextfield extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;

  const MyConfirmEmailTextfield(
      {super.key, required this.obscureText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Confirm email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      obscureText: obscureText,
    );
  }
}

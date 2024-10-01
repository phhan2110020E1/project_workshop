import 'package:flutter/material.dart';

class MyEmailTextfield extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;

  const MyEmailTextfield(
      {super.key, required this.obscureText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      obscureText: obscureText,
    );
  }
}

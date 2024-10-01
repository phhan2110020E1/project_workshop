import 'package:flutter/material.dart';

class MyPwTextfield extends StatefulWidget {
  final TextEditingController controller;

  const MyPwTextfield({super.key, required this.controller});

  @override
  State<MyPwTextfield> createState() => _MyPwTextfieldState();
}

class _MyPwTextfieldState extends State<MyPwTextfield> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'Password',
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

import 'package:flutter/material.dart';

class MyEmailTextfield extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;

  const MyEmailTextfield({Key? key, required this.formKey, required this.controller, required bool obscureText})
      : super(key: key);

  String getEmailValue() {
    return controller.text;
  }

  @override
  // ignore: library_private_types_in_public_api
  _MyEmailTextfieldState createState() => _MyEmailTextfieldState();
}

class _MyEmailTextfieldState extends State<MyEmailTextfield> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
           obscureText: false,
        validator: (value) {
          if (value == null || value.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyConfirmEmailTextfield extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

  const MyConfirmEmailTextfield(
    {Key? key, 
    required this.formKey, 
    required this.emailController}
    ): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Confirm email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        obscureText: false,
        validator: (value) {
          // Lấy giá trị email từ controller của MyEmailTextfield
          final String email = emailController.text;

          // Kiểm tra xem giá trị nhập vào có khớp với giá trị email không
          if (value != email) {
            return 'Emails do not match';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}

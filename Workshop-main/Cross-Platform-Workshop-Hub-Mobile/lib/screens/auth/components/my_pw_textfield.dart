import 'package:flutter/material.dart';

class MyPwTextfield extends StatefulWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
   const MyPwTextfield({Key? key, required this.formKey, required this.controller, required bool obscureText})
      : super(key: key);
  String getPasswordValue() {
    return controller.text;
  }
  @override
 // ignore: library_private_types_in_public_api
 _MyPwTextfieldState createState() => _MyPwTextfieldState();
}

class _MyPwTextfieldState extends State<MyPwTextfield> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key:widget.formKey,
      child: TextFormField(
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
       validator: (value) {
        // Kiểm tra xem giá trị nhập vào có phải là địa chỉ email hợp lệ hay không
        if (value == null || value.isEmpty ) {
          return 'Please enter a valid Password.';
        }
        return null; // Trả về null nếu không có lỗi
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    ),)
    ;
  }
}

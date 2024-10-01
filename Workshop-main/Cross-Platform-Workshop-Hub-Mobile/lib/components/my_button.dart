import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 7,
              offset: Offset(-6, 6),
              spreadRadius: 0,
            )
          ],
          gradient: const LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [
              Color(0xFF00AEEF),
              Color(0x832EECF8),
              Color.fromARGB(228, 255, 255, 255)
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

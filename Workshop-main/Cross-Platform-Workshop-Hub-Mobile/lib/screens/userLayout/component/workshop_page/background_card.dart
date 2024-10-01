import 'package:flutter/material.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({
    super.key,
    required this.widthRatio,
    required this.heightRatio,
  });

  final double widthRatio;
  final double heightRatio;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        width: 430 * widthRatio,
        height: 932 * heightRatio,
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [
              Color(0xFF27AAE1),
              Color(0xCF9FC9ED),
              Color(0xBEA6CDEF),
              Color(0xA4B2D4F1),
              Color(0x7AC6DFF4),
              Color(0x3A9E9E9E)
            ],
          ),
        ),
      ),
    );
  }
}
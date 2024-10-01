import 'package:flutter/material.dart';
class SessionHeader extends StatelessWidget {
  const SessionHeader({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Workshop",
          style: TextStyle(
            fontSize: screenHeight * 0.028,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "See All",
          style: TextStyle(
            fontSize: screenHeight * 0.022,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF674AEF),
          ),
        ),
      ],
    );
  }
}
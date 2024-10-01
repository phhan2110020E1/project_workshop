// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class WorkshopBottomSection extends StatelessWidget {
  final Size screenSize;

  WorkshopBottomSection({required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width * 0.8,
      height: screenSize.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Participant Reviews',
            style: TextStyle(
              fontSize: screenSize.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'John Doe: "Great experience and learning!"',
            style: TextStyle(fontSize: screenSize.width * 0.04),
          ),
          Text(
            'Jane Smith: "Highly recommend this workshop."',
            style: TextStyle(fontSize: screenSize.width * 0.04),
          ),
          // ... Add more reviews or content as needed
        ],
      ),
    );
  }
}


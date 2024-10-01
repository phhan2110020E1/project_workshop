// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class WorkshopMiddleSection extends StatelessWidget {
  final Size screenSize;

  WorkshopMiddleSection({required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width * 0.8,
      height: screenSize.height * 0.25,
      decoration: BoxDecoration(
        color: Colors.lightGreen[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Session Details',
            style: TextStyle(
              fontSize: screenSize.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Session 1: Introduction to Techniques',
            style: TextStyle(fontSize: screenSize.width * 0.04),
          ),
          Text(
            'Session 2: Advanced Strategies',
            style: TextStyle(fontSize: screenSize.width * 0.04),
          ),
          // ... Add more sessions or content as needed
        ],
      ),
    );
  }
}


// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'About Workshop: AcousticMatery',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 2,
            color: const Color(0xff4f4f4f),
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 16), // Khoảng cách giữa các đoạn văn bản
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Text(
            'Welcome to "AcousticMatery" Mastering Advanced Guitar Techniques and Solos',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 2,
              color: const Color(0xff4f4f4f),
              decoration: TextDecoration.none,
            ),
          ),
        ),
        SizedBox(height: 100),
      ],
      
    );
  }
}

// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:workshop_mobi/screens/course_screen.dart';

class DescriptionSection extends StatelessWidget{
    final CourseScreen widget;
  const DescriptionSection({super.key, required this.widget});
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text("${widget.courseResponses.description}",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
          ),
          textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
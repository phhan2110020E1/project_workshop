// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Pngwing1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.19,
      height: 140,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('lib/assets/card.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(96.50),
        ),
      ),
    );
  }
}

class YourTextAndImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Get Last Workshop',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Access largest set of courses',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const Text(
                'provided by us on your',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const Text(
                'interest',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(250, 246, 121, 105),
                  borderRadius: BorderRadius.circular(20.0), // Adjust the border radius
                ),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin:  const EdgeInsets.only( left: 25, right: 25),
                  child: const Text(
                    'Get Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
// Adjust the spacing as needed
          Pngwing1(), // Image on the right
        ],
      ),
    );
  }
}

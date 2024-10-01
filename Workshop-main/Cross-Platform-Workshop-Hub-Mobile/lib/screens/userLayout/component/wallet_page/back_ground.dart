// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[
              Color(0xff27aae1),
              Color(0xcf9fc9ed),
              Color(0xbea6cdef),
              Color(0xa4b2d4f1),
              Color(0x7ac6dff4),
              Color(0x3a9e9e9e),
            ],
            stops: <double>[0, 0.188, 0.251, 0.354, 0.521, 1],
          ),
        ),
        child: Image.asset(
          'lib/assets/Ellipse1248.png',
          height: MediaQuery.of(context).size.height * 0.5,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

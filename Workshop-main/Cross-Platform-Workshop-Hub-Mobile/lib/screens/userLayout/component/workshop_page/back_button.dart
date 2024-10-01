// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class BackButtonCustomer extends StatefulWidget {
  final double widthRatio;
  final double heightRatio;

  const BackButtonCustomer({
    super.key,
    required this.widthRatio,
    required this.heightRatio,
  });

  @override
  State<BackButtonCustomer> createState() => _BackButtonCustomerState();
}

class _BackButtonCustomerState extends State<BackButtonCustomer> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 13,
      top: 24,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 40 * widget.widthRatio,
              height: 40 * widget.widthRatio,
              decoration: const ShapeDecoration(
                color: Color.fromARGB(255, 242, 243, 245),
                shape: CircleBorder(),
              ),
            ),
            Container(
              width: 32.52 * widget.widthRatio,
              height: 32.52 * widget.heightRatio,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            Container(
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 93, 158, 201)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

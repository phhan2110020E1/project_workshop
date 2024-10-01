import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workshop_mobi/model/student/workshop_endroll.dart';

class CardQrContent extends StatelessWidget {
  const CardQrContent({
    super.key,
    required this.widthRatio,
    required this.workshopEndroll,
  });

  final double widthRatio;
  final workshopEndrollResponses workshopEndroll;

  @override
  Widget build(BuildContext context) {
    DateTime parsedDateTime = workshopEndroll.courseLocations[0].schedule_Date;

    String formattedTime = DateFormat('HH:mm:ss').format(parsedDateTime);
    return Positioned(
      left: 20 * widthRatio,
      top: 170 * widthRatio,
      child: SizedBox(
        width: 395 * widthRatio,
        height: 580 * widthRatio,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 395 * widthRatio,
                height: 580 * widthRatio,
                decoration: ShapeDecoration(
                 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(31),
                  ),
                  shadows: [
                    BoxShadow(
                      color: const Color(0x3F000000),
                      blurRadius: 4 * widthRatio,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 36 * widthRatio,
              top: 0 * widthRatio,
              child: SizedBox(
                width: 324 * widthRatio,
                height: 268 * widthRatio,
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: '\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Actor',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const TextSpan(
                        text: 'Short description:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Baloo',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const TextSpan(
                        text: ' ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Actor',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      TextSpan(
                        text: '${workshopEndroll.name}\n',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Baloo 2',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const TextSpan(
                        text: 'Location:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Baloo',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      TextSpan(
                        text: ' ${workshopEndroll.courseLocations[0].name}\n',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Baloo 2',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const TextSpan(
                        text: 'Address:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Baloo',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' ${workshopEndroll.courseLocations[0].address}\n',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Baloo 2',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const TextSpan(
                        text: 'Guess:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Baloo',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const TextSpan(
                        text: ' ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Actor',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      TextSpan(
                        text: '${workshopEndroll.teacher}\n',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Baloo 2',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const TextSpan(
                        text: 'Time:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Baloo',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const TextSpan(
                        text: ' ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Actor',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      TextSpan(
                        text: ' $formattedTime',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Baloo 2',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 70 * widthRatio,
              top: 220 * widthRatio,
              child: Image.network(
                '${workshopEndroll.urlQrCode}',
                width: 250 * widthRatio,
                height: 250 * widthRatio,
              ),
            ),
            Positioned(
                left:150 * widthRatio,
                top: 520 * widthRatio,
                child: SizedBox(
                    width: 324 * widthRatio,
                    height: 268 * widthRatio,
                    child: const Text(
                      "Thank you !",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Actor',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        decoration: TextDecoration.none,
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
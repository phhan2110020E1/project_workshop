import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workshop_mobi/model/student/workshop_endroll.dart';

class HeaderWorsshopCard extends StatelessWidget {
  const HeaderWorsshopCard({
    super.key,
    required this.widthRatio,
    required this.heightRatio,
    required this.workshopEndroll,
  });

  final double widthRatio;
  final double heightRatio;
  final workshopEndrollResponses workshopEndroll;

  @override
  Widget build(BuildContext context) {
    DateTime parsedDateTime = workshopEndroll.courseLocations[0].schedule_Date;
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDateTime);
    // String formattedTime = DateFormat('HH:mm:ss').format(parsedDateTime);
    return Positioned(
      left: 102,
      top: 42,
      child: Container(
        width: 225 * widthRatio,
        height: 200 * heightRatio,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${workshopEndroll.name}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'The Opening',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16 * widthRatio,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 200 * widthRatio,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.white.withOpacity(0.3499999940395355),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ' $formattedDate',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
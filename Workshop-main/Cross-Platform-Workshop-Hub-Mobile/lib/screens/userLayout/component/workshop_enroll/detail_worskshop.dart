// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:workshop_mobi/model/student/workshop_endroll.dart';

import 'package:workshop_mobi/screens/userLayout/component/workshop_enroll/workshop_card.dart';

class WorkshopEnrollCard extends StatelessWidget {
    final workshopEndrollResponses workshopEndroll;
  // ignore: use_key_in_widget_constructors
  const WorkshopEnrollCard({Key? key, required this.workshopEndroll});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.8, 
      height: screenHeight * 0.240,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.98, -0.18),
          end: Alignment(-0.98, 0.18),
          colors: [Color(0xFFA3E3FF), Color(0xFF6CABE3), Color(0xFF0072F0)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    '${workshopEndroll.name}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(
                    '${workshopEndroll.description}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9.5,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                       Text(
                        '${workshopEndroll.courseLocations[0].schedule_Date}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        alignment: Alignment.centerLeft,
                        height: 28,
                        width: screenWidth * 0.2,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkshopEnrolLCard(workshopEndroll: workshopEndroll,),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Explore',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ),
        ]),
      ),
    );
  }
}

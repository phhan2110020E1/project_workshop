import 'package:flutter/material.dart';

class MyCourse extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyCourse({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.8, // Adjust width based on screen width
      height: screenHeight * 0.24, // Adjust height based on screen height
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
        child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Acoustic Guitar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'The course will make you a master guitarist in less than 3 weeks.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Text(
                        'Keep your energy and stamina hyped up in every note you play...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          const Text(
                            '10/10/2023',
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
              ),
            ]),
      ),
    );
  }
}

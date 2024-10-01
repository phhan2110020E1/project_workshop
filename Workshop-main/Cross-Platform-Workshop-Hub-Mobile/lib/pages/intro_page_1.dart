import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1>
  with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double targetHeight = screenHeight * 0.06;
    
    return Scaffold(
      body: Column(
        children: [
           SizedBox(
            height: targetHeight,
          ),
          Lottie.asset(
              'lib/assets/Zyoodcd3lm.json',
              alignment: const Alignment(0, 0)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                  Text(
                    'Be thirsty for\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Stack(children: [
                    Positioned(
                      top: 31,
                      left: 18,
                      child: Container(
                        width: 200,
                        height: 6,
                        decoration:
                            const BoxDecoration(color: Color(0xFF00AEEF)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Knowledge',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold,decoration: TextDecoration.none),
                      ),
                    ),
                  ]),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                  Text(
                    'Anywhere, anytime\nFor you and your Future',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

        
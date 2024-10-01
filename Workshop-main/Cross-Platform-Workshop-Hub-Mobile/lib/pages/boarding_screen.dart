import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workshop_mobi/pages/intro_page_1.dart';
import 'package:workshop_mobi/pages/intro_page_2.dart';
import 'package:workshop_mobi/pages/intro_page_3.dart';
import 'package:workshop_mobi/screens/auth/login_or_register.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //Controller keeping track
  PageController controller = PageController();
  //See if we are on the last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        //Page view
        PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),

        //dot indicator
        Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //skip
                GestureDetector(
                    onTap: () {
                      controller.jumpToPage(2);
                    },
                    child: const Text('Skip')),

                const SizedBox(
                  width: 50,
                ),

                //dot indicator
                SmoothPageIndicator(controller: controller, count: 3),

                const SizedBox(
                  width: 50,
                ),

                //next or done
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const LoginOrReg();
                          }));
                        },
                        child: const Text('Done'))
                    : GestureDetector(
                        onTap: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: const Text('Next')),
              ],
            )),
      ],
    ));
  }
}

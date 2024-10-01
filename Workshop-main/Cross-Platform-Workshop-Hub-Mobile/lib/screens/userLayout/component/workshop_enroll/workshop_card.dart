// ignore_for_file: avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:workshop_mobi/model/student/workshop_endroll.dart';
import 'package:workshop_mobi/screens/userLayout/component/workshop_page/back_button.dart';
import 'package:workshop_mobi/screens/userLayout/component/workshop_page/background_card.dart';
import 'package:workshop_mobi/screens/userLayout/component/workshop_page/card_qr_content.dart';
import 'package:workshop_mobi/screens/userLayout/component/workshop_page/header_card.dart';

class WorkshopEnrolLCard extends StatelessWidget {
  final workshopEndrollResponses workshopEndroll;
  WorkshopEnrolLCard({Key? key, required this.workshopEndroll});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double widthRatio = screenSize.width / 430;
    double heightRatio = screenSize.height / 932;
    print(workshopEndroll);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 430 * widthRatio,
            height: 932 * heightRatio,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                BackgroundCard(
                    widthRatio: widthRatio, heightRatio: heightRatio),
                CardQrContent(
                    widthRatio: widthRatio, workshopEndroll: workshopEndroll),
                HeaderWorsshopCard(
                    widthRatio: widthRatio,
                    heightRatio: heightRatio,
                    workshopEndroll: workshopEndroll),
                BackButtonCustomer(widthRatio: widthRatio, heightRatio: heightRatio),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// ignore_for_file: unnecessary_string_interpolations, sized_box_for_whitespace, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';
import 'package:workshop_mobi/widgets/component/listworkshop/session_header.dart';
import 'package:workshop_mobi/widgets/detail_workshop.dart';

class WorkshopSection extends StatefulWidget {
  final List catNames;
  final List<Color> catColors;
  final List<Icon> catIcons;
  final List<CourseResponses> workshopList;
  WorkshopSection({
    required this.catNames,
    required this.catColors,
    required this.catIcons,
    required this.workshopList,
  });

  static Future<String?> getEmail() async {
    const storage = FlutterSecureStorage();
    String? email = await storage.read(key: "email");
    return email;
  }

  @override
  State<WorkshopSection> createState() => _WorkshopSectionState();
}

class _WorkshopSectionState extends State<WorkshopSection> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.025,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            itemCount: widget.catNames.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: screenWidth * 0.15,
                    width: screenWidth * 0.15,
                    decoration: BoxDecoration(
                      color: widget.catColors[index],
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: widget.catIcons[index]),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    widget.catNames[index],
                    style: TextStyle(
                      fontSize: screenHeight * 0.022,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  )
                ],
              );
            },
          ),
          SizedBox(height: screenHeight * 0.01),
          SessionHeader(screenHeight: screenHeight),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          SizedBox(
            height: screenHeight * 0.45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.workshopList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: screenWidth * 0.02),
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.04,
                        horizontal: screenWidth * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      color: const Color.fromARGB(94, 94, 94, 94),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Image.network(
                            "${widget.workshopList[index].courseMediaInfos[0].urlImage}",
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          widget.workshopList[index].name,
                          style: TextStyle(
                            fontSize: screenHeight * 0.028,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "${widget.workshopList[index].courseMediaInfos.length} Videos",
                          style: TextStyle(
                            fontSize: screenHeight * 0.022,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WorkshopWithFullDetailAbout(
                                          widget.workshopList[index]),
                                ),
                              );
                            },
                            child: const Text('Detail'))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

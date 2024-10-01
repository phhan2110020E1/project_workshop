// ignore_for_file: avoid_print, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/student/workshop_endroll.dart';
import 'package:workshop_mobi/screens/userLayout/component/workshop_enroll/detail_worskshop.dart';
import 'package:workshop_mobi/screens/userLayout/component/workshop_enroll/my_schedule.dart';

class ManagePage extends StatefulWidget {
  final String? token;
  ManagePage({required this.token, Key? key}) : super(key: key);
  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  double targetHeightFactor = 0.06;
  late Future<String?> userName;
  @override
  void initState() {
    super.initState();
    userName = _getUserName();
  }

  Future<String?> _getUserName() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String? userName = await storage.read(key: 'userName');
    return userName;
  }

  double convertHeight(double height) {
    return MediaQuery.of(context).size.height * height;
  }

  double convertWidth(double width) {
    return MediaQuery.of(context).size.width * width;
  }

  Future<List<workshopEndrollResponses>> fetchWorkshopEndroll(
      String token) async {
    try {
      if (token.isNotEmpty) {
        final apiService = ApiService();
        final workshopEndroll = await apiService.listWorkShopByStudent(token);
        return workshopEndroll;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching workshopEndroll: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: convertHeight(0.00),
              horizontal: convertWidth(0.025),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: convertHeight(0.01),
              horizontal: convertWidth(0.025),
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Bought Workshops',
                      style: TextStyle(
                        color: Colors.white, 
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.black, // Black shadow
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: convertHeight(0.015),
                ),
                FutureBuilder<List<workshopEndrollResponses>>(
                  future: fetchWorkshopEndroll(widget.token ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error fetching workshopEndroll');
                    } else {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var workshop in snapshot.data ?? [])
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: convertWidth(0.015),
                                ),
                                child: WorkshopEnrollCard(
                                    workshopEndroll: workshop),
                              ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: convertWidth(0.025),
              vertical: convertHeight(0.000),
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your schedule',
                      style: TextStyle(
                        color: Colors.white, // Text color white
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.black, // Black shadow
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FutureBuilder<List<workshopEndrollResponses>>(
                  future: fetchWorkshopEndroll(widget.token ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error fetching workshopEndroll');
                    } else {
                      // Chuyển đổi dữ liệu sang danh sách DateTime
                      return Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // Các WorkshopEnrollCard
                              ],
                            ),
                          ),
                          MyStudentSchedule(workshopList: snapshot.data),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/my_course.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/my_schedule.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  double targetHeightFactor = 0.06; // Tỉ lệ bạn muốn sử dụng
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7D7D7),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: convertHeight(0.00),
              horizontal: convertWidth(0.025),
            ),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     FutureBuilder<String?>(
            //       future: userName,
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.done)
            //         {
            //           return Text(
            //             'Welcome back, ${snapshot.data}',
            //             style: TextStyle(fontWeight: FontWeight.bold, ),
            //           );
            //         } else if (snapshot.hasError) {
            //           return Text('Error: ${snapshot.error}');
            //         } else {
            //           return CircularProgressIndicator();
            //         }
            //       },
            //     ),
            //   ],
            // ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: convertHeight(0.01),
              horizontal: convertWidth(0.025),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      'Your trending course',
                    ),
                  ],
                ),
                SizedBox(
                  height: convertHeight(0.015),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: convertWidth(0.015),
                        ),
                        child: const MyCourse(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: convertWidth(0.015),
                        ),
                        child: const MyCourse(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: convertWidth(0.015),
                        ),
                        child: const MyCourse(),
                      ),
                    ],
                  ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Your schedule',
                    ),
                  ],
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: convertWidth(0.015),
                        ),
                        child: const MySchedule(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: convertWidth(0.015),
                        ),
                        child: const MySchedule(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: convertWidth(0.015),
                        ),
                        child: const MySchedule(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

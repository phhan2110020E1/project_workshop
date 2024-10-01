// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:workshop_mobi/components/my_course.dart';
// import 'package:workshop_mobi/components/my_schedule.dart';

// class HhomePage extends StatefulWidget {
//   const HhomePage({super.key});

//   @override
//   State<HhomePage> createState() => _ShopPageState();
// }

// class _ShopPageState extends State<HhomePage> {
//   double targetHeightFactor = 0.06; // Tỉ lệ bạn muốn sử dụng

//   double convertHeight(double height) {
//     return MediaQuery.of(context).size.height * height;
//   }

//   double convertWidth(double width) {
//     return MediaQuery.of(context).size.width * width;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFD7D7D7),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: convertHeight(0.025),
//               horizontal: convertWidth(0.025),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome back, Hung',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: convertHeight(0.01),
//               horizontal: convertWidth(0.025),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'Your trending course',
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: convertHeight(0.015),
//                 ),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: convertWidth(0.015),
//                         ),
//                         child: MyCourse(),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: convertWidth(0.015),
//                         ),
//                         child: MyCourse(),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: convertWidth(0.015),
//                         ),
//                         child: MyCourse(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: convertWidth(0.025),
//               vertical: convertHeight(0.008),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Your schedule',
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: convertHeight(0.025),
//                 ),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: convertWidth(0.015),
//                         ),
//                         child: MySchedule(),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: convertWidth(0.015),
//                         ),
//                         child: MySchedule(),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: convertWidth(0.015),
//                         ),
//                         child: MySchedule(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

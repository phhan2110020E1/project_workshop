// import 'package:flutter/material.dart';

// class MySchedule extends StatelessWidget {
//   const MySchedule({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         Container(
//           width: screenWidth * 0.6,
//           height: screenHeight * 0.2,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
//             child: const Column(
//               children: [
//                 Text(
//                   '1',
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           width: screenWidth * 0.6,
//           height: screenHeight * 0.065,
//           decoration: const BoxDecoration(
//             color: Color.fromARGB(255, 233, 190, 173),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(16),
//               topRight: Radius.circular(16),
//             ),
//           ),
//           alignment: Alignment.center,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
//             child: const Column(
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Guitar class',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }



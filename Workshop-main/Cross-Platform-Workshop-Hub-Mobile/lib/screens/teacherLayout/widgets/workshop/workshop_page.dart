// import 'package:flutter/material.dart';
// import 'package:workshop_mobi/screens/teacherLayout/widgets/workshop/stepper_widget.dart';

// class WorkshopManager extends StatelessWidget {
//    final String token;

//   const WorkshopManager({Key? key, required this.token}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     // Lấy kích thước màn hình
//     // final Size screenSize = MediaQuery.of(context).size;
//     // Tính toán tỉ lệ chiều rộng
//     double baseWidth = 430;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;

// ignore_for_file: unused_local_variable, prefer_const_constructors, avoid_print, sized_box_for_whitespace, unnecessary_string_interpolations

//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             // courseteacherXoB (852:1261)
//             padding:
//                 EdgeInsets.fromLTRB(16 * fem, 79 * fem, 16 * fem, 112 * fem),
//             width: double.infinity,
//             height: 717 * fem,
//             decoration: BoxDecoration(
//               color: Color(0xfffdfdfd),
//             ),
//             child: Container(
//               // lessonlistingsyouteachR7s (852:1262)
//               width: double.infinity,
//               height: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   FloatingActionButton(
//                     onPressed: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => StepperWidget(token: token),
//                         ),
//                       );
//                     },
//                     child: Icon(Icons.add),
//                   ),
//                   Container(
//                     // group165wru (852:2295)
//                     width: double.infinity,
//                     height: 162 * fem,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           // autogroupzg9jHA5 (Me2Bn6Yq55ojV8NBJHzg9j)
//                           margin: EdgeInsets.fromLTRB(
//                               0 * fem, 0 * fem, 10 * fem, 0 * fem),
//                           width: 171 * fem,
//                           height: double.infinity,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 // maskgroupQkV (852:2296)
//                                 left: 0 * fem,
//                                 top: 0 * fem,
//                                 child: Container(
//                                   width: 171 * fem,
//                                   height: 162 * fem,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xff11b8f0),
//                                     borderRadius:
//                                         BorderRadius.circular(6 * fem),
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         // maskgroupQP7 (852:2298)
//                                         width: 171 * fem,
//                                         height: 162 * fem,
//                                         child: Image.asset(
//                                           'lib/assets/MaskGroup.png',
//                                           width: 171 * fem,
//                                           height: 162 * fem,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 // JjP (37171731)
//                                 left: 10 * fem,
//                                 top: 10 * fem,
//                                 child: Container(
//                                   padding: EdgeInsets.fromLTRB(
//                                       20 * fem, 5 * fem, 22 * fem, 5 * fem),
//                                   width: 78 * fem,
//                                   height: 30 * fem,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xfffdfdfd),
//                                     borderRadius:
//                                         BorderRadius.circular(6 * fem),
//                                   ),
//                                   child: Text(
//                                     'Graffitti',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 10 * ffem,
//                                       fontWeight: FontWeight.w600,
//                                       height: 2 * ffem / fem,
//                                       color: Color(0xff4c6ed7),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             // autogroupypk3K8h (Me2BvbJg1tZN1EnTTnyPK3)
//                             width: 162 * fem,
//                             height: double.infinity,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   // bacterialbiologyoverviewqcq (852:2448)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 5 * fem),
//                                   child: Text(
//                                     'Bacterial Biology Overview',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 17 * ffem,
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.8333333333 * ffem / fem,
//                                       color: Color(0xff181818),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   // autogroupx6um9Nd (Me2C564WxhJzXMCjdHx6UM)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                   width: double.infinity,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         // 51P (852:2446)
//                                         margin: EdgeInsets.fromLTRB(0 * fem,
//                                             0 * fem, 48 * fem, 0 * fem),
//                                         child: Text(
//                                           '10-10-2023',
//                                           style: TextStyle(
//                                             fontFamily: 'Inter',
//                                             fontSize: 14 * ffem,
//                                             fontWeight: FontWeight.w400,
//                                             height: 2 * ffem / fem,
//                                             color: Color(0xff4f4f4f),
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         // group19nRb (852:2455)
//                                         margin: EdgeInsets.fromLTRB(
//                                             0 * fem, 0 * fem, 1 * fem, 0 * fem),
//                                         width: 16 * fem,
//                                         height: 16 * fem,
//                                         child: Image.asset(
//                                           'lib/assets/MaskGroup.png',
//                                           width: 171 * fem,
//                                           height: 162 * fem,
//                                         ),
//                                       ),
//                                       Text(
//                                         // h30mG5s (852:2447)
//                                         '10h 30m',
//                                         textAlign: TextAlign.right,
//                                         style: TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontSize: 14 * ffem,
//                                           fontWeight: FontWeight.w400,
//                                           height: 2 * ffem / fem,
//                                           color: Color(0xff4f4f4f),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   // group338bdw (852:2459)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 40 * fem, 15 * fem),
//                                   child: IntrinsicWidth(
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           // group27LbX (852:2461)
//                                           margin: EdgeInsets.fromLTRB(0 * fem,
//                                               0 * fem, 5 * fem, 0 * fem),
//                                           width: 16 * fem,
//                                           height: 16 * fem,
//                                           child: Image.asset(
//                                             'lib/assets/MaskGroup.png',
//                                             width: 171 * fem,
//                                             height: 162 * fem,
//                                           ),
//                                         ),
//                                         Text(
//                                           // studentsFiV (852:2460)
//                                           '254 Students',
//                                           style: TextStyle(
//                                             fontFamily: 'Inter',
//                                             fontSize: 14 * ffem,
//                                             fontWeight: FontWeight.w400,
//                                             height: 2 * ffem / fem,
//                                             color: Color(0xff4f4f4f),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                   height: 40 * fem,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           width: 81 * fem,
//                                           height: double.infinity,
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Color(0xFFE0E0E0)),
//                                             color: Color(0xfffdfdfd),
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(6 * fem),
//                                               bottomLeft:
//                                                   Radius.circular(6 * fem),
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               'View',
//                                               style: TextStyle(
//                                                 fontFamily: 'Inter',
//                                                 fontSize: 15 * ffem,
//                                                 fontWeight: FontWeight.w400,
//                                                 height:
//                                                     1.8333333333 * ffem / fem,
//                                                 color: Color(0xff333333),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                           width: 81 * fem,
//                                           height: double.infinity,
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Color(0xFFE0E0E0)),
//                                             color: Color(0xfffdfdfd),
//                                             borderRadius: BorderRadius.only(
//                                               topRight:
//                                                   Radius.circular(6 * fem),
//                                               bottomRight:
//                                                   Radius.circular(6 * fem),
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               'Discuss',
//                                               style: TextStyle(
//                                                 fontFamily: 'Inter',
//                                                 fontSize: 15 * ffem,
//                                                 fontWeight: FontWeight.w400,
//                                                 height:
//                                                     1.8333333333 * ffem / fem,
//                                                 color: Color(0xff333333),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20 * fem,
//                   ),
//                   Container(
//                     // group169Reu (852:2097)
//                     width: double.infinity,
//                     height: 162 * fem,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           // autogroupyrzfkBP (Me2AZiQSHKwu8GbzDWyRZF)
//                           margin: EdgeInsets.fromLTRB(
//                               0 * fem, 0 * fem, 10 * fem, 0 * fem),
//                           width: 171 * fem,
//                           height: double.infinity,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 // maskgroupUt5 (852:2098)
//                                 left: 0 * fem,
//                                 top: 0 * fem,
//                                 child: Container(
//                                   width: 171 * fem,
//                                   height: 162 * fem,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xff11b8f0),
//                                     borderRadius:
//                                         BorderRadius.circular(6 * fem),
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         // maskgroupo9f (852:2100)
//                                         width: 171 * fem,
//                                         height: 162 * fem,
//                                         child: Image.asset(
//                                           'lib/assets/MaskGroup.png',
//                                           width: 171 * fem,
//                                           height: 162 * fem,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 // jZ7 (97725283)
//                                 left: 10 * fem,
//                                 top: 10 * fem,
//                                 child: Container(
//                                   padding: EdgeInsets.fromLTRB(
//                                       20 * fem, 5 * fem, 22 * fem, 5 * fem),
//                                   width: 78 * fem,
//                                   height: 30 * fem,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xfffdfdfd),
//                                     borderRadius:
//                                         BorderRadius.circular(6 * fem),
//                                   ),
//                                   child: Text(
//                                     'Biology',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 10 * ffem,
//                                       fontWeight: FontWeight.w600,
//                                       height: 2 * ffem / fem,
//                                       color: Color(0xff4c6ed7),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             // autogroup3lgdBg1 (Me2AhdLvEvPkVVQUvD3LgD)
//                             width: 162 * fem,
//                             height: double.infinity,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   // metabolicbiochemistryforhighsc (852:2278)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 5 * fem),
//                                   constraints: BoxConstraints(
//                                     maxWidth: 156 * fem,
//                                   ),
//                                   child: Text(
//                                     'Metabolic for High ',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 17 * ffem,
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.8333333333 * ffem / fem,
//                                       color: Color(0xff181818),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   // autogroupztvwAnq (Me2AqNd1dbcEftKKmozTVw)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                   width: double.infinity,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         // chapterfDo (852:2276)
//                                         margin: EdgeInsets.fromLTRB(0 * fem,
//                                             0 * fem, 52 * fem, 0 * fem),
//                                         child: Text(
//                                           '10 Chapter',
//                                           style: TextStyle(
//                                             fontFamily: 'Inter',
//                                             fontSize: 14 * ffem,
//                                             fontWeight: FontWeight.w400,
//                                             height: 2 * ffem / fem,
//                                             color: Color(0xff4f4f4f),
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         // group19mXj (852:2285)
//                                         margin: EdgeInsets.fromLTRB(
//                                             0 * fem, 0 * fem, 6 * fem, 0 * fem),
//                                         width: 16 * fem,
//                                         height: 16 * fem,
//                                         child: Image.asset(
//                                           'lib/assets/MaskGroup.png',
//                                           width: 171 * fem,
//                                           height: 162 * fem,
//                                         ),
//                                       ),
//                                       Text(
//                                         // h35mHky (852:2277)
//                                         '5h 35m',
//                                         textAlign: TextAlign.right,
//                                         style: TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontSize: 14 * ffem,
//                                           fontWeight: FontWeight.w400,
//                                           height: 2 * ffem / fem,
//                                           color: Color(0xff4f4f4f),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   // group3393EM (852:2289)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 5 * fem),
//                                   width: double.infinity,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         // group27ydo (852:2291)
//                                         margin: EdgeInsets.fromLTRB(
//                                             0 * fem, 0 * fem, 5 * fem, 0 * fem),
//                                         width: 16 * fem,
//                                         height: 16 * fem,
//                                         child: Image.asset(
//                                           'lib/assets/MaskGroup.png',
//                                           width: 171 * fem,
//                                           height: 162 * fem,
//                                         ),
//                                       ),
//                                       Text(
//                                         // students6Cd (852:2290)
//                                         '24 Students',
//                                         style: TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontSize: 14 * ffem,
//                                           fontWeight: FontWeight.w400,
//                                           height: 2 * ffem / fem,
//                                           color: Color(0xff4f4f4f),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                   height: 40 * fem,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           width: 81 * fem,
//                                           height: double.infinity,
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Color(0xFFE0E0E0)),
//                                             color: Color(0xfffdfdfd),
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(6 * fem),
//                                               bottomLeft:
//                                                   Radius.circular(6 * fem),
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               'View',
//                                               style: TextStyle(
//                                                 fontFamily: 'Inter',
//                                                 fontSize: 12 * ffem,
//                                                 fontWeight: FontWeight.w400,
//                                                 height:
//                                                     1.8333333333 * ffem / fem,
//                                                 color: Color(0xff333333),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                           width: 81 * fem,
//                                           height: double.infinity,
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Color(0xFFE0E0E0)),
//                                             color: Color(0xfffdfdfd),
//                                             borderRadius: BorderRadius.only(
//                                               topRight:
//                                                   Radius.circular(6 * fem),
//                                               bottomRight:
//                                                   Radius.circular(6 * fem),
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               'Discuss',
//                                               style: TextStyle(
//                                                 fontFamily: 'Inter',
//                                                 fontSize: 12 * ffem,
//                                                 fontWeight: FontWeight.w400,
//                                                 height:
//                                                     1.8333333333 * ffem / fem,
//                                                 color: Color(0xff333333),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20 * fem,
//                   ),
//                   Container(
//                     // group1785yf (852:1263)
//                     width: double.infinity,
//                     height: 162 * fem,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           // autogroupvqihEbf (Me29HqMsaJFPr596MtVQih)
//                           margin: EdgeInsets.fromLTRB(
//                               0 * fem, 0 * fem, 10 * fem, 0 * fem),
//                           width: 171 * fem,
//                           height: double.infinity,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 // maskgroupAkD (852:1264)
//                                 left: 0 * fem,
//                                 top: 0 * fem,
//                                 child: Container(
//                                   width: 171 * fem,
//                                   height: 162 * fem,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xff11b8f0),
//                                     borderRadius:
//                                         BorderRadius.circular(6 * fem),
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         // maskgrouptw7 (852:1266)
//                                         width: 171 * fem,
//                                         height: 162 * fem,
//                                         child: Image.asset(
//                                           'lib/assets/MaskGroup.png',
//                                           width: 171 * fem,
//                                           height: 162 * fem,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 // dNu (15602744)
//                                 left: 10 * fem,
//                                 top: 10 * fem,
//                                 child: Container(
//                                   padding: EdgeInsets.fromLTRB(
//                                       7 * fem, 5 * fem, 7 * fem, 5 * fem),
//                                   width: 78 * fem,
//                                   height: 30 * fem,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xfffdfdfd),
//                                     borderRadius:
//                                         BorderRadius.circular(6 * fem),
//                                   ),
//                                   child: Text(
//                                     'Mathematics',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 10 * ffem,
//                                       fontWeight: FontWeight.w600,
//                                       height: 2 * ffem / fem,
//                                       color: Color(0xff4c6ed7),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             // autogroupg7d7fKb (Me29SkGgwQ5SLFHW97G7d7)
//                             width: 162 * fem,
//                             height: double.infinity,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   // enlargementtotrigonometrybyw (852:1647)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 5 * fem),
//                                   constraints: BoxConstraints(
//                                     maxWidth: 87 * fem,
//                                   ),
//                                   child: Text(
//                                     'Enlargeme',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 17 * ffem,
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.8333333333 * ffem / fem,
//                                       color: Color(0xff181818),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   // autogroupi1yp4Mj (Me29bug69skXbfGPgxi1yP)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                   width: double.infinity,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         // chapternoX (852:1645)
//                                         margin: EdgeInsets.fromLTRB(0 * fem,
//                                             0 * fem, 52 * fem, 0 * fem),
//                                         child: Text(
//                                           '10 Chapter',
//                                           style: TextStyle(
//                                             fontFamily: 'Inter',
//                                             fontSize: 14 * ffem,
//                                             fontWeight: FontWeight.w400,
//                                             height: 2 * ffem / fem,
//                                             color: Color(0xff4f4f4f),
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         // group21ut9 (852:1654)
//                                         margin: EdgeInsets.fromLTRB(
//                                             0 * fem, 0 * fem, 6 * fem, 0 * fem),
//                                         width: 16 * fem,
//                                         height: 16 * fem,
//                                         child: Image.asset(
//                                           'lib/assets/MaskGroup.png',
//                                           width: 171 * fem,
//                                           height: 162 * fem,
//                                         ),
//                                       ),
//                                       Text(
//                                         // h35mcnZ (852:1646)
//                                         '5h 35m',
//                                         textAlign: TextAlign.right,
//                                         style: TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontSize: 14 * ffem,
//                                           fontWeight: FontWeight.w400,
//                                           height: 2 * ffem / fem,
//                                           color: Color(0xff4f4f4f),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   // group342A3P (852:1658)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 77 * fem, 23 * fem),
//                                   width: double.infinity,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         // group27tk5 (852:1660)
//                                         margin: EdgeInsets.fromLTRB(
//                                             0 * fem, 0 * fem, 5 * fem, 0 * fem),
//                                         width: 16 * fem,
//                                         height: 16 * fem,
//                                         child: Image.asset(
//                                           'lib/assets/MaskGroup.png',
//                                           width: 171 * fem,
//                                           height: 162 * fem,
//                                         ),
//                                       ),
//                                       Text(
//                                         // kstudentsdBs (852:1659)
//                                         '1.2k Students',
//                                         style: TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontSize: 14 * ffem,
//                                           fontWeight: FontWeight.w400,
//                                           height: 2 * ffem / fem,
//                                           color: Color(0xff4f4f4f),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                   height: 40 * fem,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           width: 81 * fem,
//                                           height: double.infinity,
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Color(0xFFE0E0E0)),
//                                             color: Color(0xfffdfdfd),
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(6 * fem),
//                                               bottomLeft:
//                                                   Radius.circular(6 * fem),
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               'View',
//                                               style: TextStyle(
//                                                 fontFamily: 'Inter',
//                                                 fontSize: 12 * ffem,
//                                                 fontWeight: FontWeight.w400,
//                                                 height:
//                                                     1.8333333333 * ffem / fem,
//                                                 color: Color(0xff333333),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                           width: 81 * fem,
//                                           height: double.infinity,
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Color(0xFFE0E0E0)),
//                                             color: Color(0xfffdfdfd),
//                                             borderRadius: BorderRadius.only(
//                                               topRight:
//                                                   Radius.circular(6 * fem),
//                                               bottomRight:
//                                                   Radius.circular(6 * fem),
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               'Discuss',
//                                               style: TextStyle(
//                                                 fontFamily: 'Inter',
//                                                 fontSize: 12 * ffem,
//                                                 fontWeight: FontWeight.w400,
//                                                 height:
//                                                     1.8333333333 * ffem / fem,
//                                                 color: Color(0xff333333),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/edit_workshop/edit_workshop_page.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/workshop/stepper_widget.dart';
import 'package:workshop_mobi/api/api_service.dart';

class WorkshopManager extends StatefulWidget {
  final String token;
  final List<CourseResponses> workshopList;

  const WorkshopManager({
    Key? key,
    required this.token,
    required this.workshopList,
  }) : super(key: key);

  @override
  State<WorkshopManager> createState() => _WorkshopManagerState();
}

bool isWorkshopPassed(DateTime startDate) {
  // Compare the workshop's startDate with the current date and time
  return startDate.isBefore(DateTime.now());
}

List<CourseResponses> publicWorkshops = [];
List<CourseResponses> pendingWorkshops = [];

class _WorkshopManagerState extends State<WorkshopManager> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final apiService = ApiService();
    print("Building WorkshopManager widget");

    return Scaffold(
       appBar: AppBar(
        title: Center(child: Text("Workshop Manager")),
      ),
      body: FutureBuilder<List<CourseResponses>>(
          future: apiService.listWorkShopTeacher(widget.token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available.'));
            } else {
              List<CourseResponses> workshopList = snapshot.data!;
              print("Length of workshopList: ${workshopList.length}");
              print(
                  "URL of the first workshop: ${workshopList[0].courseMediaInfos[0].urlImage}");
              return SingleChildScrollView(
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        16 * fem, 79 * fem, 16 * fem, 112 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xfffdfdfd),
                    ),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...workshopList.map((workshop) {
                            if (workshop.isPublic) {
                              publicWorkshops.add(workshop);
                            } else {
                              pendingWorkshops.add(workshop);
                            }
                            Color backgroundColor = workshop.isPublic
                                ? Color.fromARGB(255, 119, 119,
                                    119) // Color for public workshops
                                : Color.fromARGB(255, 253, 253,
                                    253); // Color for pending workshops
                            return Container(
                              //       padding: EdgeInsets.fromLTRB(
                              // 0 * fem, 10 * Rfem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              height: 162 * fem,
                              margin: EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                color: workshop.isPublic
                                    ? Color.fromARGB(255, 255, 255,
                                        255) // Color for public workshops
                                    : Color.fromARGB(158, 150, 150,
                                        150), // Color for pending workshops
                                borderRadius: BorderRadius.circular(10 * fem),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 10 * fem, 0 * fem),
                                    width: 171 * fem,
                                    height: double.infinity,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0 * fem,
                                          top: 0 * fem,
                                          child: Container(
                                            width: 171 * fem,
                                            height: 162 * fem,
                                            decoration: BoxDecoration(
                                              color: Color(0xff11b8f0),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      6 * fem),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 171 * fem,
                                                  height: 162 * fem,
                                                  child: Image.network(
                                                    "${workshop.courseMediaInfos[0].urlImage}",
                                                    width: 171 * fem,
                                                    height: 162 * fem,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 10 * fem,
                                          top: 10 * fem,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                20 * fem,
                                                5 * fem,
                                                22 * fem,
                                                5 * fem),
                                            width: 78 * fem,
                                            height: 30 * fem,
                                            decoration: BoxDecoration(
                                              color: Color(0xfffdfdfd),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      6 * fem),
                                            ),
                                            child: Text(
                                              "${workshop.price}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 10 * ffem,
                                                fontWeight: FontWeight.w600,
                                                height: 2 * ffem / fem,
                                                color: Color(0xff4c6ed7),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 162 * fem,
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // bacterialbiologyoverviewqcq (852:2448)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 5 * fem),
                                            child: Text(
                                              "${workshop.name}",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.8333333333 * ffem / fem,
                                                color: Color(0xff181818),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // autogroupx6um9Nd (Me2C564WxhJzXMCjdHx6UM)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 10 * fem),
                                            width: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // 51P (852:2446)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      48 * fem,
                                                      0 * fem),
                                                  child: Text(
                                                    "${workshop.startDate}",
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: 14 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 2 * ffem / fem,
                                                      color: Color(0xff4f4f4f),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 77 * fem, 23 * fem),
                                            width: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      5 * fem,
                                                      0 * fem),
                                                  width: 16 * fem,
                                                  height: 16 * fem,
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 20 * fem,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "${workshop.student_count}",
                                                  style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 14 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 2 * ffem / fem,
                                                    color: Color(0xff4f4f4f),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 40 * fem,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    width: 81 * fem,
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              0xFFE0E0E0)),
                                                      color: Color(0xfffdfdfd),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                6 * fem),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                6 * fem),
                                                      ),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        if (!isWorkshopPassed(
                                                            workshop
                                                                .startDate)) {
                                                          // Only navigate to the EditWorkshopPage if the workshop is not passed
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditWorkshopPage(
                                                                token: widget
                                                                    .token,
                                                                workshopId:
                                                                    workshop.id,
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          // Workshop has passed, show a message or perform other actions
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              title: Text(
                                                                  'Workshop Has Passed'),
                                                              content: Text(
                                                                  'This workshop has already passed.'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child: Text(
                                                                      'OK'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          'View',
                                                          style: TextStyle(
                                                            fontFamily: 'Inter',
                                                            fontSize: 12 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height:
                                                                1.8333333333 *
                                                                    ffem /
                                                                    fem,
                                                            color: Color(
                                                                0xff333333),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    width: 81 * fem,
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              0xFFE0E0E0)),
                                                      color: Color(0xfffdfdfd),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                6 * fem),
                                                        bottomRight:
                                                            Radius.circular(
                                                                6 * fem),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Discuss',
                                                        style: TextStyle(
                                                          fontFamily: 'Inter',
                                                          fontSize: 12 * ffem,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.8333333333 *
                                                              ffem /
                                                              fem,
                                                          color:
                                                              Color(0xff333333),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          SizedBox(height: 20 * fem),
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StepperWidget(token: widget.token),
            ),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}

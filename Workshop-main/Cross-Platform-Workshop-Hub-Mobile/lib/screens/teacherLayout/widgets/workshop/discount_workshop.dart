// import 'dart:io';

// import 'package:flutter/material.dart';

// class DiscountPage extends StatelessWidget {
//   const DiscountPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     // final controller = Get.put(SupplierAddProductController());
//     // Lấy kích thước màn hình
//     final Size screenSize = MediaQuery.of(context).size;
//     double baseWidth = 430;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;

//     return SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               // makeclassteacherAPX (854:2527)
//               padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 71 * fem),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Color(0xfffdfdfd),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Container(
//                   //   // maskgroupDch (863:3443)
//                   //   margin: EdgeInsets.fromLTRB(
//                   //       0 * fem, 0 * fem, 0 * fem, 38 * fem),
//                   //   padding: EdgeInsets.fromLTRB(
//                   //       29.93 * fem, 28 * fem, 29.43 * fem, 75 * fem),
//                   //   width: double.infinity,
//                   //   decoration: BoxDecoration(
//                   //     color: Color(0xff11b8f0),
//                   //     borderRadius: BorderRadius.only(
//                   //       bottomRight: Radius.circular(187.5 * fem),
//                   //       bottomLeft: Radius.circular(187.5 * fem),
//                   //     ),
//                   //     image: DecorationImage(
//                   //       fit: BoxFit.cover,
//                   //       image: AssetImage(
//                   //         'lib/assets/MaskGroupadd.png',
//                   //       ),
//                   //     ),
//                   //   ),
//                   //   child: Column(
//                   //     crossAxisAlignment: CrossAxisAlignment.center,
//                   //     children: [
//                   //       Container(
//                   //         // stepertD3 (863:2401)
//                   //         margin: EdgeInsets.fromLTRB(
//                   //             0 * fem, 50 * fem, 0 * fem, 30 * fem),
//                   //         width: double.infinity,
//                   //         height: 34 * fem,
//                   //         child: Stack(
//                   //           children: [
//                   //             Positioned(
//                   //               // step1oT (I863:2401;102:3517)
//                   //               left: 0 * fem,
//                   //               top: 0 * fem,
//                   //               child: Container(
//                   //                 width: 97.41 * fem,
//                   //                 height: 34 * fem,
//                   //                 child: Column(
//                   //                   crossAxisAlignment:
//                   //                       CrossAxisAlignment.center,
//                   //                   children: [
//                   //                     Container(
//                   //                       // rowLqj (I863:2401;102:3517;102:3460)
//                   //                       width: double.infinity,
//                   //                       height: 16 * fem,
//                   //                       child: Row(
//                   //                         crossAxisAlignment:
//                   //                             CrossAxisAlignment.center,
//                   //                         children: [
//                   //                           Container(
//                   //                             // col1VTj (I863:2401;102:3517;102:3461)
//                   //                             margin: EdgeInsets.fromLTRB(
//                   //                                 0 * fem,
//                   //                                 0 * fem,
//                   //                                 0 * fem,
//                   //                                 0 * fem),
//                   //                             width: 40.7 * fem,
//                   //                             height: double.infinity,
//                   //                           ),
//                   //                           Container(
//                   //                             // col22Tf (I863:2401;102:3517;102:3462)
//                   //                             width: 16 * fem,
//                   //                             height: 16 * fem,
//                   //                             child: Image.asset(
//                   //                               'lib/assets/Circle1.png',
//                   //                               width: 16 * fem,
//                   //                               height: 16 * fem,
//                   //                             ),
//                   //                           ),
//                   //                           Container(
//                   //                             // col3y81 (I863:2401;102:3517;102:3464)
//                   //                             width: 40.7 * fem,
//                   //                             height: 2 * fem,

//                   //                             child: Image.asset(
//                   //                               'lib/assets/Col.png',
//                   //                               width: 40.7 * fem,
//                   //                               height: 2 * fem,
//                   //                             ),
//                   //                           ),
//                   //                         ],
//                   //                       ),
//                   //                     ),
//                   //                     Center(
//                   //                       // placeholder6iR (I863:2401;102:3517;102:3466;102:3493)
//                   //                       child: Container(
//                   //                         margin: EdgeInsets.fromLTRB(0 * fem,
//                   //                             0 * fem, 0 * fem, 0 * fem),
//                   //                         child: Text(
//                   //                           'Details',
//                   //                           textAlign: TextAlign.center,
//                   //                           style: TextStyle(
//                   //                             fontFamily: 'ABeeZee',
//                   //                             fontSize: 12 * ffem,
//                   //                             fontWeight: FontWeight.w400,
//                   //                             height: 1.5 * ffem / fem,
//                   //                             color: Color(0xff898f8f),
//                   //                           ),
//                   //                         ),
//                   //                       ),
//                   //                     ),
//                   //                   ],
//                   //                 ),
//                   //               ),
//                   //             ),
//                   //             Positioned(
//                   //               // stepmZf (I863:2401;102:3518)
//                   //               left: 97.4096679688 * fem,
//                   //               top: 0 * fem,
//                   //               child: Container(
//                   //                 width: 97.41 * fem,
//                   //                 height: 34 * fem,
//                   //                 child: Column(
//                   //                   crossAxisAlignment:
//                   //                       CrossAxisAlignment.center,
//                   //                   children: [
//                   //                     Container(
//                   //                       // rowHH7 (I863:2401;102:3518;102:3442)
//                   //                       width: double.infinity,
//                   //                       child: Row(
//                   //                         crossAxisAlignment:
//                   //                             CrossAxisAlignment.center,
//                   //                         children: [
//                   //                           Container(
//                   //                             // col1d65 (I863:2401;102:3518;102:3443)
//                   //                             margin: EdgeInsets.fromLTRB(
//                   //                                 0 * fem,
//                   //                                 0 * fem,
//                   //                                 0 * fem,
//                   //                                 0 * fem),
//                   //                             width: 40.7 * fem,
//                   //                             height: 2 * fem,
//                   //                             child: Image.asset(
//                   //                               'lib/assets/Col.png',
//                   //                               width: 40.7 * fem,
//                   //                               height: 2 * fem,
//                   //                             ),
//                   //                           ),
//                   //                           Container(
//                   //                             // col2M25 (I863:2401;102:3518;102:3445)
//                   //                             width: 16 * fem,
//                   //                             height: 16 * fem,
//                   //                             child: Image.asset(
//                   //                               'lib/assets/Circle2.png',
//                   //                               width: 16 * fem,
//                   //                               height: 16 * fem,
//                   //                             ),
//                   //                           ),
//                   //                           Container(
//                   //                             // col3UsP (I863:2401;102:3518;102:3447)
//                   //                             width: 40.7 * fem,
//                   //                             height: 2 * fem,
//                   //                             child: Image.asset(
//                   //                               'lib/assets/Col.png',
//                   //                               width: 40.7 * fem,
//                   //                               height: 2 * fem,
//                   //                             ),
//                   //                           ),
//                   //                         ],
//                   //                       ),
//                   //                     ),
//                   //                     Center(
//                   //                       // placeholder2P7 (I863:2401;102:3518;102:3449;102:3495)
//                   //                       child: Container(
//                   //                         margin: EdgeInsets.fromLTRB(0 * fem,
//                   //                             0 * fem, 0 * fem, 0 * fem),
//                   //                         child: Text(
//                   //                           'Location',
//                   //                           textAlign: TextAlign.center,
//                   //                           style: TextStyle(
//                   //                             fontFamily: 'ABeeZee',
//                   //                             fontSize: 12 * ffem,
//                   //                             fontWeight: FontWeight.w400,
//                   //                             height: 1.5 * ffem / fem,
//                   //                             color: Color(0xff000000),
//                   //                           ),
//                   //                         ),
//                   //                       ),
//                   //                     ),
//                   //                   ],
//                   //                 ),
//                   //               ),
//                   //             ),
//                   //             Positioned(
//                   //               // stepjHX (I863:2401;102:3519)
//                   //               left: 194.8193359375 * fem,
//                   //               top: 0 * fem,
//                   //               child: Container(
//                   //                 width: 97.41 * fem,
//                   //                 height: 34 * fem,
//                   //                 child: Column(
//                   //                   crossAxisAlignment:
//                   //                       CrossAxisAlignment.center,
//                   //                   children: [
//                   //                     Container(
//                   //                       // row4Ko (I863:2401;102:3519;102:3425)
//                   //                       width: double.infinity,
//                   //                       child: Row(
//                   //                         crossAxisAlignment:
//                   //                             CrossAxisAlignment.center,
//                   //                         children: [
//                   //                           Container(
//                   //                             // col121j (I863:2401;102:3519;102:3426)
//                   //                             margin: EdgeInsets.fromLTRB(
//                   //                                 0 * fem,
//                   //                                 0 * fem,
//                   //                                 0 * fem,
//                   //                                 0 * fem),
//                   //                             width: 40.7 * fem,
//                   //                             height: 2 * fem,
//                   //                             child: Image.asset(
//                   //                               'lib/assets/Col.png',
//                   //                               width: 40.7 * fem,
//                   //                               height: 2 * fem,
//                   //                             ),
//                   //                           ),
//                   //                           Container(
//                   //                             // col2YEy (I863:2401;102:3519;102:3428)
//                   //                             width: 16 * fem,
//                   //                             height: 16 * fem,
//                   //                             child: Image.asset(
//                   //                               'lib/assets/Circle3.png',
//                   //                               width: 16 * fem,
//                   //                               height: 16 * fem,
//                   //                             ),
//                   //                           ),
//                   //                           Container(
//                   //                             // col35Vo (I863:2401;102:3519;102:3430)
//                   //                             width: 40.7 * fem,
//                   //                             height: 2 * fem,
//                   //                             child: Image.asset(
//                   //                               'lib/assets/Col.png',
//                   //                               width: 40.7 * fem,
//                   //                               height: 2 * fem,
//                   //                             ),
//                   //                           ),
//                   //                         ],
//                   //                       ),
//                   //                     ),
//                   //                     Center(
//                   //                       // placeholderRZf (I863:2401;102:3519;102:3432;102:3493)
//                   //                       child: Container(
//                   //                         margin: EdgeInsets.fromLTRB(0 * fem,
//                   //                             0 * fem, 0 * fem, 0 * fem),
//                   //                         child: Text(
//                   //                           'Discount',
//                   //                           textAlign: TextAlign.center,
//                   //                           style: TextStyle(
//                   //                             fontFamily: 'ABeeZee',
//                   //                             fontSize: 12 * ffem,
//                   //                             fontWeight: FontWeight.w400,
//                   //                             height: 1.5 * ffem / fem,
//                   //                             color: Color(0xff898f8f),
//                   //                           ),
//                   //                         ),
//                   //                       ),
//                   //                     ),
//                   //                   ],
//                   //                 ),
//                   //               ),
//                   //             ),
//                   //             Positioned(
//                   //               // stepk69 (I863:2401;102:3520)
//                   //               left: 292.2290039062 * fem,
//                   //               top: 0 * fem,
//                   //               child: Container(
//                   //                 width: 97.41 * fem,
//                   //                 height: 34 * fem,
//                   //                 child: Column(
//                   //                   crossAxisAlignment:
//                   //                       CrossAxisAlignment.center,
//                   //                   children: [
//                   //                     Container(
//                   //                       // rowgVb (I863:2401;102:3520;102:3476)
//                   //                       width: double.infinity,
//                   //                       height: 16 * fem,
//                   //                       child: Row(
//                   //                         crossAxisAlignment:
//                   //                             CrossAxisAlignment.center,
//                   //                         children: [
//                   //                           Container(
//                   //                             // col1qdP (I863:2401;102:3520;102:3477)
//                   //                             margin: EdgeInsets.fromLTRB(
//                   //                                 0 * fem,
//                   //                                 0 * fem,
//                   //                                 0 * fem,
//                   //                                 0 * fem),
//                   //                             width: 40.7 * fem,
//                   //                             height: 2 * fem,
//                   //                             child: Image.asset(
//                   //                               'lib/assets/Col.png',
//                   //                               width: 40.7 * fem,
//                   //                               height: 2 * fem,
//                   //                             ),
//                   //                           ),
//                   //                           Container(
//                   //                             // col2Mrd (I863:2401;102:3520;102:3479)
//                   //                             width: 16 * fem,
//                   //                             height: 16 * fem,
//                   //                             child: Image.asset(
//                   //                               'lib/assets/Circle3.png',
//                   //                               width: 16 * fem,
//                   //                               height: 16 * fem,
//                   //                             ),
//                   //                           ),
//                   //                           Container(
//                   //                             // col3VT3 (I863:2401;102:3520;102:3481)
//                   //                             width: 40.7 * fem,
//                   //                             height: double.infinity,
//                   //                           ),
//                   //                         ],
//                   //                       ),
//                   //                     ),
//                   //                     Center(
//                   //                       // placeholdereKw (I863:2401;102:3520;102:3482;102:3493)
//                   //                       child: Container(
//                   //                         margin: EdgeInsets.fromLTRB(0 * fem,
//                   //                             0 * fem, 0 * fem, 0 * fem),
//                   //                         child: Text(
//                   //                           'Finish',
//                   //                           textAlign: TextAlign.center,
//                   //                           style: TextStyle(
//                   //                             fontFamily: 'ABeeZee',
//                   //                             fontSize: 12 * ffem,
//                   //                             fontWeight: FontWeight.w400,
//                   //                             height: 1.5 * ffem / fem,
//                   //                             color: Color(0xff898f8f),
//                   //                           ),
//                   //                         ),
//                   //                       ),
//                   //                     ),
//                   //                   ],
//                   //                 ),
//                   //               ),
//                   //             ),
//                   //           ],
//                   //         ),
//                   //       ),
//                   //       Container(
//                   //         // whatdoyouwanttoteachinyourwork (854:2565)
//                   //         margin: EdgeInsets.fromLTRB(
//                   //             11.65 * fem, 0 * fem, 0 * fem, 0 * fem),
//                   //         constraints: BoxConstraints(
//                   //           maxWidth: 322 * fem,
//                   //         ),
//                   //         child: Text(
//                   //           'WHAT DO YOU WANT TO TEACH IN YOUR WORKSHOP?',
//                   //           textAlign: TextAlign.center,
//                   //           style: TextStyle(
//                   //             fontFamily: 'Inter',
//                   //             fontSize: 24 * ffem,
//                   //             fontWeight: FontWeight.w400,
//                   //             height: 1.4166666667 * ffem / fem,
//                   //             color: Color(0xfffdfdfd),
//                   //           ),
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),

//                   Container(
//                     // autogrouprvzdE3F (Pa9fW194SsGEgyWGjYrVzD)
//                     margin:
//                         EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
//                     width: double.infinity,
//                     height: 78 * fem,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // categoryY3w (854:2556)
//                             margin: EdgeInsets.fromLTRB(
//                                 5 * fem, 0 * fem, 5 * fem, 0 * fem),
//                             width: 210 * fem,
//                             height: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4 * fem),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   // workshoptitle4HB (854:2558)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                   child: Text(
//                                     'Quantity',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 18 * ffem,
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.8333333333 * ffem / fem,
//                                       color: Color(0xff181818),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     // autogroup3gxdZzd (Pa9gAehL7niyzY7f623gxD)
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       border:
//                                           Border.all(color: Color(0xffe0e0e0)),
//                                       color: Color(0xfff2f2f2),
//                                       borderRadius:
//                                           BorderRadius.circular(4 * fem),
//                                     ),
//                                     // Thay thế Text bằng TextField
//                                     child: TextField(
//                                       decoration: InputDecoration(
//                                         hintStyle: TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontSize: 18 * ffem,
//                                           fontWeight: FontWeight.w400,
//                                           height: 1.5 * ffem / fem,
//                                           color: Color(0xffbdbdbd),
//                                         ),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   Container(
//                     // autogrouprvzdE3F (Pa9fW194SsGEgyWGjYrVzD)
//                     margin:
//                         EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
//                     width: double.infinity,
//                     height: 78 * fem,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // categoryY3w (854:2556)
//                             margin: EdgeInsets.fromLTRB(
//                                 5 * fem, 0 * fem, 5 * fem, 0 * fem),
//                             width: 210 * fem,
//                             height: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4 * fem),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   // workshoptitle4HB (854:2558)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                   child: Text(
//                                     'redemption Date',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 18 * ffem,
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.8333333333 * ffem / fem,
//                                       color: Color(0xff181818),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     // autogroup3gxdZzd (Pa9gAehL7niyzY7f623gxD)
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       border:
//                                           Border.all(color: Color(0xffe0e0e0)),
//                                       color: Color(0xfff2f2f2),
//                                       borderRadius:
//                                           BorderRadius.circular(4 * fem),
//                                     ),
//                                     // Thay thế Text bằng TextField
//                                     child: TextField(
//                                       decoration: InputDecoration(
//                                         hintStyle: TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontSize: 18 * ffem,
//                                           fontWeight: FontWeight.w400,
//                                           height: 1.5 * ffem / fem,
//                                           color: Color(0xffbdbdbd),
//                                         ),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   Container(
//                     // autogrouprvzdE3F (Pa9fW194SsGEgyWGjYrVzD)
//                     margin:
//                         EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
//                     width: double.infinity,
//                     height: 78 * fem,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // categoryY3w (854:2556)
//                             margin: EdgeInsets.fromLTRB(
//                                 5 * fem, 0 * fem, 5 * fem, 0 * fem),
//                             width: 210 * fem,
//                             height: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4 * fem),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   // workshoptitle4HB (854:2558)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                   child: Text(
//                                     'valueDiscount',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 18 * ffem,
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.8333333333 * ffem / fem,
//                                       color: Color(0xff181818),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     // autogroup3gxdZzd (Pa9gAehL7niyzY7f623gxD)
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       border:
//                                           Border.all(color: Color(0xffe0e0e0)),
//                                       color: Color(0xfff2f2f2),
//                                       borderRadius:
//                                           BorderRadius.circular(4 * fem),
//                                     ),
//                                     // Thay thế Text bằng TextField
//                                     child: TextField(
//                                       decoration: InputDecoration(
//                                         hintStyle: TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontSize: 18 * ffem,
//                                           fontWeight: FontWeight.w400,
//                                           height: 1.5 * ffem / fem,
//                                           color: Color(0xffbdbdbd),
//                                         ),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     // autogrouprvzdE3F (Pa9fW194SsGEgyWGjYrVzD)
//                     margin:
//                         EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
//                     width: double.infinity,
//                     height: 78 * fem,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // categoryY3w (854:2556)
//                             margin: EdgeInsets.fromLTRB(
//                                 5 * fem, 0 * fem, 5 * fem, 0 * fem),
//                             width: 210 * fem,
//                             height: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4 * fem),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   // workshoptitle4HB (854:2558)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                   child: Text(
//                                     'name',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 18 * ffem,
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.8333333333 * ffem / fem,
//                                       color: Color(0xff181818),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     // autogroup3gxdZzd (Pa9gAehL7niyzY7f623gxD)
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       border:
//                                           Border.all(color: Color(0xffe0e0e0)),
//                                       color: Color(0xfff2f2f2),
//                                       borderRadius:
//                                           BorderRadius.circular(4 * fem),
//                                     ),
//                                     // Thay thế Text bằng TextField
//                                     child: TextField(
//                                       decoration: InputDecoration(
//                                         hintStyle: TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontSize: 18 * ffem,
//                                           fontWeight: FontWeight.w400,
//                                           height: 1.5 * ffem / fem,
//                                           color: Color(0xffbdbdbd),
//                                         ),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   Container(
//                     // autogrouprvzdE3F (Pa9fW194SsGEgyWGjYrVzD)
//                     margin:
//                         EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
//                     width: double.infinity,
//                     height: 78 * fem,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // categoryY3w (854:2556)
//                             margin: EdgeInsets.fromLTRB(
//                                 5 * fem, 0 * fem, 5 * fem, 0 * fem),
//                             width: 210 * fem,
//                             height: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4 * fem),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   // workshoptitle4HB (854:2558)
//                                   margin: EdgeInsets.fromLTRB(
//                                       0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                   child: Text(
//                                     'Description',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 18 * ffem,
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.8333333333 * ffem / fem,
//                                       color: Color(0xff181818),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(

//                                     // autogroup3gxdZzd (Pa9gAehL7niyzY7f623gxD)
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       border:
//                                           Border.all(color: Color(0xffe0e0e0)),
//                                       color: Color(0xfff2f2f2),
//                                       borderRadius:
//                                           BorderRadius.circular(4 * fem),
//                                     ),
//                                     // Thay thế Text bằng TextField
//                                     child: TextField(
//                                       decoration: InputDecoration(
//                                         hintStyle: TextStyle(
//                                           fontFamily: 'Inter',
//                                           fontSize: 18 * ffem,
//                                           fontWeight: FontWeight.w400,
//                                           height: 1.5 * ffem / fem,
//                                           color: Color(0xffbdbdbd),
//                                         ),
//                                         border: InputBorder.none,
//                                           contentPadding: EdgeInsets.symmetric(vertical: 12 * fem),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                       ],
//                     ),
//                   ),

//                  // Container(
//                   //   // buttonmakeyourclassGQV (854:2528)
//                   //   margin: EdgeInsets.fromLTRB(
//                   //       32 * fem, 0 * fem, 32 * fem, 0 * fem),
//                   //   padding: EdgeInsets.fromLTRB(
//                   //       123 * fem, 18 * fem, 121 * fem, 18 * fem),
//                   //   width: double.infinity,
//                   //   decoration: BoxDecoration(
//                   //     borderRadius: BorderRadius.circular(6 * fem),
//                   //     gradient: LinearGradient(
//                   //       begin: Alignment(0, -1),
//                   //       end: Alignment(0, 2.667),
//                   //       colors: <Color>[
//                   //         Color(0xff00aeef),
//                   //         Color(0xef06b6f0),
//                   //         Color(0xe00bbdf1),
//                   //         Color(0xd80ec1f2),
//                   //         Color(0xca13c8f3),
//                   //         Color(0x832eecf8),
//                   //         Color(0x0028e898)
//                   //       ],
//                   //       stops: <double>[0, 0.064, 0.126, 0.156, 0.214, 0.5, 1],
//                   //     ),
//                   //   ),
//                   //   child: Row(
//                   //     crossAxisAlignment: CrossAxisAlignment.center,
//                   //     children: [
//                   //       Text(
//                   //         // makeyourclasss9P (854:2530)
//                   //         'Make Your Class',
//                   //         textAlign: TextAlign.center,
//                   //         style: TextStyle(
//                   //           fontFamily: 'Inter',
//                   //           fontSize: 18 * ffem,
//                   //           fontWeight: FontWeight.w400,
//                   //           height: 1.5555555556 * ffem / fem,
//                   //           color: Color(0xfffdfdfd),
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//     );
//   }
// }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(DetailsPage());
// }
// class DetailsPage extends StatefulWidget {
//   const DetailsPage({Key? key}) : super(key: key);

//   @override
//   _DetailsPageState createState() => _DetailsPageState();
// }

// class _DetailsPageState extends State<DetailsPage> {
//   PickedFile? _image;
//   String imageUrl = '';
//   // Đặt biến tại mức độ của lớp
//   int selectedStartDay = DateTime.now().day;
//   int selectedStartMonth = DateTime.now().month;
//   int selectedStartYear = DateTime.now().year;

//   int selectedEndDay = DateTime.now().day;
//   int selectedEndMonth = DateTime.now().month;
//   int selectedEndYear = DateTime.now().year;

//   @override
//   Widget build(BuildContext context) {
//     // final controller = Get.put(SupplierAddProductController());
//     // Lấy kích thước màn hình

//     final Size screenSize = MediaQuery.of(context).size;
//     double baseWidth = 430;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;
//     DateTime selectedDate = DateTime.now();
//     Future<String> uploadImageToFirebase(XFile image) async {
//       firebase_storage.Reference storageReference = firebase_storage
//           .FirebaseStorage.instance
//           .ref()
//           .child('images/${DateTime.now().millisecondsSinceEpoch}');

//       // Upload ảnh lên Firebase Storage
//       firebase_storage.UploadTask uploadTask =
//           storageReference.putFile(File(image.path));

//       // Chờ quá trình upload hoàn thành
//       await uploadTask.whenComplete(() => print('Image uploaded'));

//       // Lấy đường link của ảnh
//       String imageUrl = await storageReference.getDownloadURL();

//       return imageUrl;
//     }
//   Future<void> getImage() async {
//     final ImagePicker _picker = ImagePicker();
//     XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Upload ảnh lên Firebase Storage và nhận đường link
//       String imageUrl = await uploadImageToFirebase(pickedFile);

//       // Cập nhật đường link ảnh và tái tạo widget
//       setState(() {
//         this.imageUrl = imageUrl;
//       });

//       print('Image URL: $imageUrl');
//       print('Image path: ${pickedFile.path}');
//     }
//   }

//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(

//             padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 71 * fem),
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Color(0xfffdfdfd),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [

//                 Container(
//                   // autogrouprvzdE3F (Pa9fW194SsGEgyWGjYrVzD)
//                   margin:
//                       EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
//                   width: double.infinity,
//                   height: 78 * fem,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Container(
//                           // categoryY3w (854:2556)
//                           margin: EdgeInsets.fromLTRB(
//                               5 * fem, 0 * fem, 5 * fem, 0 * fem),
//                           width: 210 * fem,
//                           height: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4 * fem),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 // workshoptitle4HB (854:2558)
//                                 margin: EdgeInsets.fromLTRB(
//                                     0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                 child: Text(
//                                   'Workshop Title',
//                                   style: TextStyle(
//                                     fontFamily: 'Inter',
//                                     fontSize: 18 * ffem,
//                                     fontWeight: FontWeight.w400,
//                                     height: 1.8333333333 * ffem / fem,
//                                     color: Color(0xff181818),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   // autogroup3gxdZzd (Pa9gAehL7niyzY7f623gxD)
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     border:
//                                         Border.all(color: Color(0xffe0e0e0)),
//                                     color: Color(0xfff2f2f2),
//                                     borderRadius:
//                                         BorderRadius.circular(4 * fem),
//                                   ),
//                                   // Thay thế Text bằng TextField
//                                   child: TextField(
//                                     decoration: InputDecoration(
//                                       hintStyle: TextStyle(
//                                         fontFamily: 'Inter',
//                                         fontSize: 18 * ffem,
//                                         fontWeight: FontWeight.w400,
//                                         height: 1.5 * ffem / fem,
//                                         color: Color(0xffbdbdbd),
//                                       ),
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 Container(
//                   // autogrouprvzdE3F (Pa9fW194SsGEgyWGjYrVzD)
//                   margin:
//                       EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
//                   width: double.infinity,
//                   height: 78 * fem,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Container(
//                           // categoryY3w (854:2556)
//                           margin: EdgeInsets.fromLTRB(
//                               5 * fem, 0 * fem, 5 * fem, 0 * fem),
//                           width: 210 * fem,
//                           height: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4 * fem),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 // workshoptitle4HB (854:2558)
//                                 margin: EdgeInsets.fromLTRB(
//                                     0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                 child: Text(
//                                   'Cost',
//                                   style: TextStyle(
//                                     fontFamily: 'Inter',
//                                     fontSize: 18 * ffem,
//                                     fontWeight: FontWeight.w400,
//                                     height: 1.8333333333 * ffem / fem,
//                                     color: Color(0xff181818),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   // autogroup3gxdZzd (Pa9gAehL7niyzY7f623gxD)
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     border:
//                                         Border.all(color: Color(0xffe0e0e0)),
//                                     color: Color(0xfff2f2f2),
//                                     borderRadius:
//                                         BorderRadius.circular(4 * fem),
//                                   ),
//                                   // Thay thế Text bằng TextField
//                                   child: TextField(
//                                     decoration: InputDecoration(
//                                       hintStyle: TextStyle(
//                                         fontFamily: 'Inter',
//                                         fontSize: 18 * ffem,
//                                         fontWeight: FontWeight.w400,
//                                         height: 1.5 * ffem / fem,
//                                         color: Color(0xffbdbdbd),
//                                       ),
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 Container(
//                   // autogrouprvzdE3F (Pa9fW194SsGEgyWGjYrVzD)
//                   margin:
//                       EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
//                   width: double.infinity,
//                   height: 78 * fem,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Container(
//                           // categoryY3w (854:2556)
//                           margin: EdgeInsets.fromLTRB(
//                               5 * fem, 0 * fem, 5 * fem, 0 * fem),
//                           width: 210 * fem,
//                           height: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4 * fem),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.fromLTRB(
//                                     0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     ElevatedButton(
//                                       child: const Text("Select Start Date"),
//                                       onPressed: () async {
//                                         final DateTime? dateTime =
//                                             await showDatePicker(
//                                           context: context,
//                                           initialDate: selectedDate,
//                                           firstDate: DateTime(2000),
//                                           lastDate: DateTime(3000),
//                                         );
//                                         if (dateTime != null) {
//                                           // Cập nhật giá trị của biến tại mức độ của lớp
//                                           selectedStartDay = dateTime.day;
//                                           selectedStartMonth = dateTime.month;
//                                           selectedStartYear = dateTime.year;

//                                           // Gọi setState để tái tạo widget
//                                           setState(() {});
//                                         }
//                                       },
//                                     ),
//                                     Text(
//                                       "$selectedStartDay - $selectedStartMonth - $selectedStartYear",
//                                       style: TextStyle(
//                                         fontFamily: 'Inter',
//                                         fontSize: 18 * ffem,
//                                         fontWeight: FontWeight.w400,
//                                         height: 1.8333333333 * ffem / fem,
//                                         color: Color(0xff181818),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   // autogrouprvzdE3F (Pa9fW194SsGEgyWGjYrVzD)
//                   margin:
//                       EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
//                   width: double.infinity,
//                   height: 78 * fem,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Container(
//                           // categoryY3w (854:2556)
//                           margin: EdgeInsets.fromLTRB(
//                               5 * fem, 0 * fem, 5 * fem, 0 * fem),
//                           width: 210 * fem,
//                           height: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4 * fem),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               ElevatedButton(
//                                 child: const Text("Select End Date"),
//                                 onPressed: () async {
//                                   final DateTime? dateTime =
//                                       await showDatePicker(
//                                     context: context,
//                                     initialDate: selectedDate,
//                                     firstDate: DateTime(2000),
//                                     lastDate: DateTime(3000),
//                                   );
//                                   if (dateTime != null) {
//                                     // Cập nhật giá trị của biến tại mức độ của lớp
//                                     selectedEndDay = dateTime.day;
//                                     selectedEndMonth = dateTime.month;
//                                     selectedEndYear = dateTime.year;

//                                     // Gọi setState để tái tạo widget
//                                     setState(() {});
//                                   }
//                                 },
//                               ),
//                               Text(
//                                 "$selectedEndDay - $selectedEndMonth - $selectedEndYear",
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontSize: 18 * ffem,
//                                   fontWeight: FontWeight.w400,
//                                   height: 1.8333333333 * ffem / fem,
//                                   color: Color(0xff181818),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 Container(
//                   // autogrouprvzdE3F (Pa9fW194SsGEgyWGjYrVzD)
//                   margin:
//                       EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
//                   width: double.infinity,
//                   height: 78 * fem,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Container(
//                           // categoryY3w (854:2556)
//                           margin: EdgeInsets.fromLTRB(
//                               5 * fem, 0 * fem, 5 * fem, 0 * fem),
//                           width: 210 * fem,
//                           height: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4 * fem),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 // workshoptitle4HB (854:2558)
//                                 margin: EdgeInsets.fromLTRB(
//                                     0 * fem, 0 * fem, 0 * fem, 10 * fem),
//                                 child: Text(
//                                   'Description',
//                                   style: TextStyle(
//                                     fontFamily: 'Inter',
//                                     fontSize: 18 * ffem,
//                                     fontWeight: FontWeight.w400,
//                                     height: 1.8333333333 * ffem / fem,
//                                     color: Color(0xff181818),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   // autogroup3gxdZzd (Pa9gAehL7niyzY7f623gxD)
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     border:
//                                         Border.all(color: Color(0xffe0e0e0)),
//                                     color: Color(0xfff2f2f2),
//                                     borderRadius:
//                                         BorderRadius.circular(4 * fem),
//                                   ),
//                                   // Thay thế Text bằng TextField
//                                   child: TextField(
//                                     decoration: InputDecoration(
//                                       hintStyle: TextStyle(
//                                         fontFamily: 'Inter',
//                                         fontSize: 18 * ffem,
//                                         fontWeight: FontWeight.w400,
//                                         height: 1.5 * ffem / fem,
//                                         color: Color(0xffbdbdbd),
//                                       ),
//                                       border: InputBorder.none,
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical: 12 * fem),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//            Column(
//   children: [
//     // Hiển thị hình ảnh đã chọn (nếu có)
//     imageUrl.isNotEmpty
//         ? Image.network(
//             imageUrl,
//             height: 100, // Thay đổi kích thước theo ý của bạn
//             width: 100,
//           )
//         : Container(), // Ẩn nếu không có ảnh

//     // Nút chọn ảnh
//     Container(
//       margin: EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
//       width: double.infinity,
//       height: 60 * fem,
//       decoration: BoxDecoration(
//         border: Border.all(color: Color(0xffe0e0e0)),
//         color: Color(0xfff2f2f2),
//         borderRadius: BorderRadius.circular(4 * fem),
//       ),
//       child: ElevatedButton(
//         onPressed: getImage, // Gọi hàm getImage khi nút được nhấn
//         style: ElevatedButton.styleFrom(
//           primary: Colors.transparent,
//           elevation: 0,
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Upload Image',
//               style: TextStyle(
//                 fontFamily: 'Inter',
//                 fontSize: 18 * ffem,
//                 fontWeight: FontWeight.w400,
//                 height: 2 * ffem / fem,
//                 color: Color(0xff4f4f4f),
//               ),
//             ),
//             SizedBox(width: 8 * fem),
//             Icon(
//               Icons.cloud_upload,
//               size: 18.47 * fem,
//               color: Colors.blue,
//             ),
//           ],
//         ),
//       ),
//     ),
//   ],
// )

//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'dart:typed_data';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:workshop_mobi/screens/userLayout/widgets/workshop/resources/add_date.dart';
// import 'package:workshop_mobi/screens/userLayout/widgets/workshop/resources/utils.dart';

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const DetailsPage());
// }

// class DetailsPage extends StatefulWidget {
//    const DetailsPage({Key? key}) : super(key: key);

//   @override
//   _DetailsPageState createState() => _DetailsPageState();
// }
// class _DetailsPageState extends State<DetailsPage> {
//   Uint8List? _image;
// final TextEditingController nameController = TextEditingController();
//  final TextEditingController bioController = TextEditingController();
// @override
//   void initState() {
//     super.initState();
//     // Initialize Firebase when the widget is created
//     Firebase.initializeApp();
//   }

//   void selectImage() async {
//     Uint8List img = await pickImage(ImageSource.gallery);
//     setState(() {
//       _image = img;
//     });
//   }

//   void saveProfile() async{

//       String name = nameController.text;
//       String bio = bioController.text;

//       String resp = await StoreData().saveData(name: name, bio: bio, file: _image!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(

//         child: Container(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 32,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 24,
//               ),
//               Stack(
//                 children: [
//                   _image != null
//                       ? CircleAvatar(
//                           radius: 64,
//                           backgroundImage: MemoryImage(_image!),
//                         )
//                       : const CircleAvatar(
//                           radius: 64,
//                           backgroundImage: NetworkImage(
//                               'https://png.pngitem.com/pimgs/s/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png'),
//                         ),
//                   Positioned(
//                     bottom: -10,
//                     left: 80,
//                     child: IconButton(
//                       onPressed: selectImage,
//                       icon: const Icon(Icons.add_a_photo),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//                TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter Name',
//                   contentPadding: EdgeInsets.all(10),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//                TextField(
//                 controller: bioController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter Bio',
//                   contentPadding: EdgeInsets.all(10),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               ElevatedButton(
//                 onPressed: saveProfile,
//                 child: const Text('Save Profile'),
//               )
//             ],
//           ),
//         ),
//     );
//   }
// }

// ignore_for_file: avoid_print, prefer_const_constructors, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:workshop_mobi/controller/teacher/add_workshop_controller.dart';
import 'package:workshop_mobi/model/workshopResquest.dart';
import 'package:intl/intl.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage(
      {Key? key,
      required this.controller,
      required this.token,
      required Null Function(CourseRequest workshop) onDiscountChanged})
      : super(key: key);
  final String token;
  final AddWorkshopController controller;

  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController remainingUsesController = TextEditingController();
  final TextEditingController valueDiscountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController redemptionDateController =
      TextEditingController();

  DateTime? selectedRedemptionDate;

  Future<void> _selectedRedemptionDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: (widget.controller.startDate)
          .value, // Extract DateTime value from Rx stream
      lastDate: (widget.controller.endDate).value,
    );
    if (picked != null && picked != selectedRedemptionDate) {
      if (picked.isAfter((widget.controller.startDate).value) &&
          picked.isBefore((widget.controller.endDate).value)) {
        setState(() {
          selectedRedemptionDate = picked;
          redemptionDateController.text =
              DateFormat('yyyy-MM-dd').format(picked);
          updateController();
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid Redemption Date'),
            content: Text(
                ' Redemption Date must be within the range of Start Date and End Date.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Add listeners to controllers
    quantityController.addListener(updateController);
    remainingUsesController.addListener(updateController);
    valueDiscountController.addListener(updateController);
    nameController.addListener(updateController);
    descriptionController.addListener(updateController);
    redemptionDateController.addListener(updateController);
  }

  // Update the controller when any field changes
  void updateController() {
    print('updateController called');
    if (nameController.text.isNotEmpty && selectedRedemptionDate  != null&&
        descriptionController.text.isNotEmpty &&
        valueDiscountController.text.isNotEmpty &&
        quantityController != null) {
      print('updateController isNotEmpty called');
      widget.controller.addDiscountDTO(
          quantity: int.tryParse(quantityController.text) ?? 0,
          redemptionDate: selectedRedemptionDate ?? DateTime.now(),
          valueDiscount: int.tryParse(valueDiscountController.text) ?? 0,
          name: nameController.text,
          description: descriptionController.text,
          remainingUses: int.tryParse(remainingUsesController.text) ?? 0);
      print(
          'widget.controller.discountDTOs (from controller): ${widget.controller.discountDTOs}');
      print(
          'widget.controller.addDiscountDTO (from controller): ${widget.controller.addDiscountDTO}');
      print(
          'quantity (from controller): ${widget.controller.discountDTOs[0]['quantity']}');
          print(          'name (from controller): ${widget.controller.discountDTOs[0]['name']}');
      print(
          'redemptionDate (from controller): ${widget.controller.discountDTOs[0]['redemptionDate']}');
      print(
          'valueDiscount (from controller): ${widget.controller.discountDTOs[0]['valueDiscount']}');
      print(
          'description (from controller): ${widget.controller.discountDTOs[0]['description']}');
      print(
          'remainingUses (from controller): ${widget.controller.discountDTOs[0]['quantity']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Discount Name',
                hintText: 'Enter Discount Name',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Discount name cannot be empty';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter Description',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Description cannot be empty';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: redemptionDateController,
              onTap: () => _selectedRedemptionDate(context),
              decoration: InputDecoration(
                labelText: 'Redemption Date',
                hintText: 'Redemption Date',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: valueDiscountController,
              decoration: InputDecoration(
                labelText: 'Value Discount ',
                hintText: 'Value Discount',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}$')), // Chỉ cho phép nhập số
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Value Discount cannot be empty';
                }
                try {
                  final double price = double.parse(value);
                  if (price <= 0) {
                    throw FormatException();
                  }
                } catch (e) {
                  return 'Value Discount must be a valid positive number';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
                hintText: 'Quantity',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}$')), // Chỉ cho phép nhập số
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Quantity cannot be empty';
                }
                try {
                  final double price = double.parse(value);
                  if (price <= 0) {
                    throw FormatException();
                  }
                } catch (e) {
                  return 'Quantity must be a valid positive number';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
          ],
        ),
      ),
    );
  }
}

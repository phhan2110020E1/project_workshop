// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class IconHeader extends StatelessWidget {
  const IconHeader({
    super.key,
    required this.fem,
    required this.ffem,
  });

  final double fem;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 12.3012695312 * fem,
      top: 10.763671875 * fem,
      child: SizedBox(
        width: 427.17 * fem,
        height: 179.14 * fem,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopIcon(fem: fem, ffem: ffem),
            BottomIcon(fem: fem, ffem: ffem),
          ],
        ),
      ),
    );
  }
}

class TopIcon extends StatelessWidget {
  const TopIcon({
    super.key,
    required this.fem,
    required this.ffem,
  });

  final double fem;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 123.78 * fem),
      width: double.infinity,
      height: 24.6 * fem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 24.6 * fem,
            height: 24.6 * fem,
            decoration: BoxDecoration(
              color: Colors.white, // Màu nền trắng
              shape: BoxShape
                  .circle, 
            ),
            child: Icon(
              Icons.arrow_back,
              size: 24.6 * fem,
              color: Colors.black,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(12.3 * fem, 0 * fem, 0 * fem, 0 * fem),
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 294.66 * fem, 1.07 * fem),
                  child: Text(
                    '',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 2 * ffem / fem,
                      color: const Color(0xff4f4f4f),
                    ),
                  ),
                ),
                SizedBox(
                  // group1171274784bLX (I688:3028;769:36961)
                  width: 24.6 * fem,
                  height: 24.6 * fem,
                  child: Icon(
                    Icons.favorite, // Thay thế với biểu tượng bạn chọn
                    size: 24.6 * fem, // Kích thước của icon
                    color: Colors.red, // Màu sắc của icon
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

class BottomIcon extends StatelessWidget {
  const BottomIcon({
    super.key,
    required this.fem,
    required this.ffem,
  });

  final double fem;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0.41 * fem, 0 * fem),
      width: double.infinity,
      height: 30.75 * fem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // group473902gj (I688:3028;769:36892)
            margin:
                EdgeInsets.fromLTRB(0 * fem, 0 * fem, 200.67 * fem, 0 * fem),
            width: 100.91 * fem,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19.989648819 * fem),
            ),
            child: Container(
              // frame626087x4b (I688:3028;769:36893)
              padding: EdgeInsets.fromLTRB(
                  3.08 * fem, 3.08 * fem, 3.08 * fem, 3.08 * fem),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff0f172a),
                borderRadius: BorderRadius.circular(19.989648819 * fem),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x14342969),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 20 * fem,
                  ),
                ],
              ),
              child: SizedBox(
                // frame626108T1M (I688:3028;769:36894)
                width: 80.91 * fem,
                height: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // frame626081ykP (I688:3028;769:36895)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 2.31 * fem, 0 * fem),
                      width: 24.6 * fem,
                      height: 24.6 * fem,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(17.6831512451 * fem),
                        child: Image.network(
                          'https://inkythuatso.com/uploads/thumbnails/800/2023/02/hinh-anh-cho-con-de-thuong-chay-tung-tang-1-24-11-43-28.jpg',
                        ),
                      ),
                    ),
                    Container(
                      child: Flexible(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          'By Maria 123',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 2 * ffem / fem,
                              color: const Color.fromARGB(255, 255, 252, 252),
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.fromLTRB(14 * fem, 0.38 * fem, 0 * fem, 0.38 * fem),
            width: 48.44 * fem,
            height: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xfff4624d),
              borderRadius: BorderRadius.circular(19.989648819 * fem),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x51dc5a3e),
                  offset: Offset(0 * fem, 3.0753304958 * fem),
                  blurRadius: 15.3766527176 * fem,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '\$911',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 2 * ffem / fem,
                    color: const Color(0xff4f4f4f),
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

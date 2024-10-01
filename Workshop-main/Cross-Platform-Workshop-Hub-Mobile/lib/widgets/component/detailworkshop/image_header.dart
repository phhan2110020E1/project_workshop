import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  const ImageHeader({
    super.key,
    required this.fem
  });

  final double fem;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0 * fem,
      right: 10*fem,
      top: 0 * fem,
      child: Container(
      
        width: 250.59 * fem,
        height: 174.53 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.9143180847 * fem),
          gradient:const LinearGradient(
            begin: Alignment(-0, -1),
            end: Alignment(-0, -0.207),
            colors: <Color>[Color(0x7f000000), Color(0x7f000000)],
            stops: <double>[0, 1],
          ),
          image:const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://hoangthuong.net/wp-content/uploads/2022/05/hinh-anh-cho-con-de-thuong-27.jpg'),
          ),
        ),
      ),
    );
  }
}
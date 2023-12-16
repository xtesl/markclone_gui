import 'package:flutter/material.dart';

class EmailValidator {
  static RegExp pattern = RegExp(r'^[\w-\.]+@([\w-\.]+\.)+[\w]{2,4}$');
}

/*
Circular bottom container design
================================
*/

class CircularBottomClipper extends CustomClipper<Path> {
  final double circularHeight;
  final double curvature;

  CircularBottomClipper(this.circularHeight, this.curvature);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - circularHeight * curvature);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - circularHeight * curvature,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

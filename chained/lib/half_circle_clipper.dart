import 'package:flutter/material.dart';

enum HalfCircleSide { left, right }

class HalfCircleClipper extends CustomClipper<Path> {
  final HalfCircleSide side;

  HalfCircleClipper(this.side);

  @override
  Path getClip(Size size) {
    final Path path = Path();
    late Offset offset;
    late bool clockWise;
    switch (side) {
      case HalfCircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockWise = false;
        break;
      case HalfCircleSide.right:
        offset = Offset(0, size.height);
        clockWise = true;
        break;
    }
    path.arcToPoint(offset,
        radius: Radius.circular(size.width / 2), clockwise: clockWise);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

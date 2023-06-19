import 'dart:math';

import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  late final AnimationController _controler;
  late final Animation<int> _animation;
  late final Animation<double> _radiusAnimation;

  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controler =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = IntTween(begin: 3, end: 10).animate(_controler);
    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_controler);
    _radiusAnimation = Tween<double>(begin: 20, end: 400).animate(_controler);
    _controler.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AnimatedBuilder(
              animation: Listenable.merge(
                  [_animation, _radiusAnimation, _rotationAnimation]),
              builder: (context, _) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_rotationAnimation.value)
                    ..rotateY(_rotationAnimation.value)
                    ..rotateZ(_rotationAnimation.value),
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: CustomPaint(
                      painter: PolygonPainter(_animation.value),
                      child: SizedBox(
                        width: _radiusAnimation.value,
                        height: _radiusAnimation.value,
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class PolygonPainter extends CustomPainter {
  final int sides;
  const PolygonPainter(this.sides);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final path = Path();

    final center = Offset(size.width / 2, size.height / 2);
    final angle = 2 * pi / sides;
    final angles = List.generate(sides, (index) => index * angle);

    final radius = size.width / 2;

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    for (var i = 0; i < angles.length; i++) {
      // var p1 = Offset(center.dx + radius * cos(angles[i]),
      //     center.dy + radius * sin(angles[i]));
      // var p2 = Offset(center.dx + radius * cos(angles[i + 1]),
      //     center.dy + radius * sin(angles[i + 1]));
      // _drawDashedLine(
      // canvas: canvas,
      // p1: p1,
      // p2: p2,
      // dashWidth: 12,
      // dashSpace: 12,
      // paint: paint);
      path.lineTo(
        center.dx + radius * cos(angles[i]),
        center.dy + radius * sin(angles[i]),
      );
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PolygonPainter oldDelegate) {
    return oldDelegate.sides != sides;
  }

  void _drawDashedLine({
    required Canvas canvas,
    required Offset p1,
    required Offset p2,
    required int dashWidth,
    required int dashSpace,
    required Paint paint,
  }) {
    // Get normalized distance vector from p1 to p2
    var dx = p2.dx - p1.dx;
    var dy = p2.dy - p1.dy;
    final magnitude = sqrt(dx * dx + dy * dy);
    dx = dx / magnitude;
    dy = dy / magnitude;

    // Compute number of dash segments
    final steps = magnitude ~/ (dashWidth + dashSpace);

    var startX = p1.dx;
    var startY = p1.dy;

    for (int i = 0; i < steps; i++) {
      final endX = startX + dx * dashWidth;
      final endY = startY + dy * dashWidth;
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
      startX += dx * (dashWidth + dashSpace);
      startY += dy * (dashWidth + dashSpace);
    }
  }
}

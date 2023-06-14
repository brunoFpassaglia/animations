import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  var _color = getRandomColor();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: Center(
          child: ClipPath(
            clipper: const CircleClipper(),
            child: TweenAnimationBuilder(
              duration: Duration(seconds: 1),
              tween: ColorTween(
                begin: getRandomColor(),
                end: _color,
              ),
              onEnd: () => setState(() {
                _color = getRandomColor();
              }),
              builder: (context, value, child) => Container(
                color: value,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Color getRandomColor() => Color(0xFF000000 + Random().nextInt(0xFFFFFF));

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();

  @override
  Path getClip(Size size) {
    var path = Path();

    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);

    path.addOval(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

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
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                origin: Offset(50, 50),
                transform: Matrix4.identity()..rotateY(_animation.value),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 5,
                            offset: const Offset(0, 3)),
                      ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

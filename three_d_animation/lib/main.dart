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

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  late AnimationController _animationYAxisController;
  late AnimationController _animationXAxisController;
  late AnimationController _animationZAxisController;
  late Tween<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    _animationXAxisController =
        AnimationController(vsync: this, duration: Duration(seconds: 15));
    _animationYAxisController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animationZAxisController =
        AnimationController(vsync: this, duration: Duration(seconds: 30));
    _animation = Tween<double>(begin: 0, end: pi * 2);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationXAxisController.dispose();
    _animationYAxisController.dispose();
    _animationZAxisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationXAxisController
      ..reset()
      ..repeat();
    _animationYAxisController
      ..reset()
      ..repeat();
    _animationZAxisController
      ..reset()
      ..repeat();

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100, width: double.infinity),
              AnimatedBuilder(
                animation: Listenable.merge([
                  _animationXAxisController,
                  _animationYAxisController,
                  _animationZAxisController,
                ]),
                builder: ((context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateX(_animation.evaluate(_animationXAxisController))
                      ..rotateY(_animation.evaluate(_animationYAxisController))
                      ..rotateZ(_animation.evaluate(_animationZAxisController)),
                    child: Stack(
                      children: [
                        Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0, 80.0),
                          alignment: Alignment.center,
                          child: Container(
                            color: Colors.red,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Transform(
                          alignment: Alignment.bottomRight,
                          transform: Matrix4.identity()..rotateY(pi / 2),
                          child: Container(
                            color: Colors.blue,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()..rotateY(-pi / 2),
                          child: Container(
                            color: Colors.pink,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()..rotateX(-pi / 2),
                          child: Container(
                            color: Colors.black,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Transform(
                          alignment: Alignment.topLeft,
                          transform: Matrix4.identity()..rotateX(pi / 2),
                          child: Container(
                            color: Colors.green,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Container(
                          color: Colors.yellow,
                          width: 80,
                          height: 80,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

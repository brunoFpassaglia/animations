import 'dart:math';

import 'package:chained/half_circle_clipper.dart';
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
  late AnimationController _animationRotationZController;

  late Animation<double> _animationRotationZ;

  late AnimationController _flipAnimationController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _animationRotationZController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animationRotationZ = Tween<double>(begin: 0, end: -(pi / 2)).animate(
        CurvedAnimation(
            parent: _animationRotationZController, curve: Curves.bounceOut));

    _flipAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _flipAnimation =
        Tween<double>(begin: 0, end: pi).animate(_flipAnimationController);

    _animationRotationZ.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
                begin: _flipAnimation.value, end: pi + _flipAnimation.value)
            .animate(_flipAnimationController);

        _flipAnimationController
          ..reset()
          ..forward();
      }
    });
    _flipAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationRotationZ = Tween<double>(
          begin: _animationRotationZ.value,
          end: _animationRotationZ.value - (pi / 2),
        ).animate(CurvedAnimation(
            parent: _animationRotationZController, curve: Curves.bounceOut));

        _animationRotationZController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    _animationRotationZController.dispose();
    _flipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      _animationRotationZController
        ..reset()
        ..forward();
    });
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 64),
          child: AnimatedBuilder(
              animation: _animationRotationZController,
              builder: (context, _) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(_animationRotationZ.value),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _flipAnimationController,
                        builder: (context, child) {
                          return Transform(
                            transform: Matrix4.identity()
                              ..rotateY(_flipAnimation.value),
                            alignment: Alignment.centerRight,
                            child: ClipPath(
                              clipper: HalfCircleClipper(HalfCircleSide.left),
                              child: Container(
                                color: Colors.blue,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          );
                        },
                      ),
                      AnimatedBuilder(
                          animation: _flipAnimationController,
                          builder: (context, child) {
                            return Transform(
                              transform: Matrix4.identity()
                                ..rotateY(_flipAnimation.value),
                              alignment: Alignment.centerLeft,
                              child: ClipPath(
                                clipper:
                                    HalfCircleClipper(HalfCircleSide.right),
                                child: Container(
                                  color: Colors.yellow,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

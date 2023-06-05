import 'package:flutter/material.dart';
import 'package:hero/main.dart';

class DetailsPage extends StatelessWidget {
  final Person person;
  const DetailsPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Hero(
        flightShuttleBuilder: (flightContext, animation, flightDirection,
            fromHeroContext, toHeroContext) {
          switch (flightDirection) {
            case HeroFlightDirection.push:
              return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                      scale: animation.drive(Tween<double>(
                              begin: fromHeroContext.size!.height, end: 50)
                          //   .chain(
                          // CurveTween(
                          //   curve: Curves.fastOutSlowIn,
                          // ),
                          // ),
                          ),
                      child: toHeroContext.widget));
            case HeroFlightDirection.pop:
              return Material(
                  color: Colors.transparent, child: fromHeroContext.widget);
          }
        },
        tag: person.hashCode,
        child: Container(
          width: 50,
          height: 50,
          color: Colors.red,
        ),
      )),
    );
  }
}

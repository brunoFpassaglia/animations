import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

const defaultWidth = 100.0;

class _MainAppState extends State<MainApp> {
  var _isZoomedIn = false;
  var _buttonTitle = 'Zoom in';
  var _width = defaultWidth;
  var _curve = Curves.bounceOut;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Home page')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: _curve,
                width: _width,
                child: Image.asset('assets/wallpaper.jpg'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isZoomedIn = !_isZoomedIn;
                    _buttonTitle = _isZoomedIn ? 'Zoom out' : 'Zoom in';
                    _width = _isZoomedIn
                        ? MediaQuery.of(context).size.width
                        : defaultWidth;
                  });
                },
                child: Text(_buttonTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

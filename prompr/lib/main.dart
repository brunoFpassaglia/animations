import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('prompt'),
        ),
        body: const Center(
          child: AnimatedPrompt(
              title: 'title', subtitle: 'subtitle', child: Icon(Icons.check)),
        ),
      ),
    );
  }
}

class AnimatedPrompt extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget child;
  const AnimatedPrompt({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  State<AnimatedPrompt> createState() => _AnimatedPromptState();
}

class _AnimatedPromptState extends State<AnimatedPrompt>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _containerScaleAnimation;
  late Animation<Offset> _yDisplacementAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _yDisplacementAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -0.2))
            .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _iconScaleAnimation = Tween<double>(begin: 7, end: 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _containerScaleAnimation = Tween<double>(begin: 4, end: 1 / 4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller
      ..reset()
      ..forward();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.pink,
        ),
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 100,
              minWidth: 100,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 160),
                      Text(
                        '${widget.title} aksdjhf  a;lsdjfopia alskdjfpq',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.subtitle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: SlideTransition(
                    position: _yDisplacementAnimation,
                    child: ScaleTransition(
                        scale: _containerScaleAnimation,
                        child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: ScaleTransition(
                              scale: _iconScaleAnimation,
                              child: widget.child,
                            ))),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

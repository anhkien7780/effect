import 'package:flutter/material.dart';

class Playground extends StatelessWidget {
  const Playground({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AnimationExample());
  }
}

class AnimationExample extends StatefulWidget {
  const AnimationExample({super.key});

  @override
  State<AnimationExample> createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  Animation<double> opacityAnimation = const AlwaysStoppedAnimation(0.0);
  final duration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void togglePlayAction() {
    if (controller.status == AnimationStatus.completed) {
      controller.reverse();
    } else if (controller.status == AnimationStatus.dismissed) {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animation Playground")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          togglePlayAction();
        },
        child: Icon(Icons.play_arrow),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: opacityAnimation,
          builder: (context, Widget? child) {
            return Opacity(
              opacity: opacityAnimation.value,
              child: child,
            );
          },
          child: Text("A Thing", style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}

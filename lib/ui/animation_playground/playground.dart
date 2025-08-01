import 'dart:math';

import 'package:flutter/material.dart';

class Playground extends StatelessWidget {
  const Playground({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return MaterialApp(home: WaveContainer(screenSize: screenSize));
  }
}

class WaveContainer extends StatefulWidget {
  const WaveContainer({super.key, required this.screenSize});

  final Size screenSize;

  @override
  State<WaveContainer> createState() => _WaveContainerState();
}

class _WaveContainerState extends State<WaveContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _left;

  @override
  void initState() {
    super.initState();
    final screenSize = widget.screenSize;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    _left = Tween<double>(
      begin: -50,
      end: screenSize.width,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseY = widget.screenSize.height / 2 - 100;
    double amplitude = 50;
    return Scaffold(
      appBar: AppBar(title: Text("Animation Playground")),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              double radians = _controller.value * 10 * pi;
              double sinY = baseY + sin(radians) * amplitude;
              return Positioned(
                left: _left.value,
                top: sinY,
                child: child!,
              );
            },
            child: Container(color: Colors.blue, width: 50, height: 50),
          ),
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class CircleLoading extends StatefulWidget {
  const CircleLoading({super.key, this.circleSize});

  final Size? circleSize;

  @override
  State<CircleLoading> createState() => _CircleLoadingState();
}

class _CircleLoadingState extends State<CircleLoading>
    with TickerProviderStateMixin {
  late AnimationController _circleLoadingController;
  late AnimationController _confirmTickController;

  @override
  void initState() {
    super.initState();
    _circleLoadingController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..forward();

    _confirmTickController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _circleLoadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) _confirmTickController.forward();
    });
  }

  @override
  void dispose() {
    _circleLoadingController.dispose();
    _confirmTickController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _circleLoadingController,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: CirclePainter(_circleLoadingController.value),
                  size: widget.circleSize ?? const Size(100, 100),
                );
              },
            ),
            AnimatedBuilder(
              animation: _confirmTickController,
              builder: (context, child) {
                return Opacity(
                  opacity: _confirmTickController.value,
                  child: child,
                );
              },
              child: SizedBox(child: Icon(size: 150, Icons.offline_pin_sharp)),
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;

  const CirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 6.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round;

    final angle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

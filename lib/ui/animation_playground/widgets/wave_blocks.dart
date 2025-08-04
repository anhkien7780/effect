import 'package:flutter/material.dart';

class WaveBlocks extends StatelessWidget {
  const WaveBlocks({
    super.key,
    required this.animationDuration,
    required this.blockCount,
  });

  final Duration animationDuration;
  final int blockCount;

  @override
  Widget build(BuildContext context) {
    final animationDurationMilliseconds = animationDuration.inMilliseconds;

    final delay = Duration(
      milliseconds: (animationDurationMilliseconds / (blockCount * 2)).toInt(),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(blockCount, (index) {
              return RowWave(
                blockCount: blockCount,
                delay: delay * index,
                animationDuration: animationDuration,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class RowWave extends StatefulWidget {
  const RowWave({
    super.key,
    required this.blockCount,
    required this.delay,
    required this.animationDuration,
  });

  final int blockCount;
  final Duration delay;
  final Duration animationDuration;

  @override
  State<RowWave> createState() => _RowWaveState();
}

class _RowWaveState extends State<RowWave> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _fadeIns = [];
  late final List<Animation<double>> _fadeOuts = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    Future.delayed(widget.delay, () {
      _controller.repeat();
    });

    double unit = 1.0 / (widget.blockCount * 2);

    for (int i = 0; i < widget.blockCount; i++) {
      final double fadeInStart = i * unit;
      final double fadeInEnd = fadeInStart + unit;
      _fadeIns.add(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(fadeInStart, fadeInEnd, curve: Curves.easeIn),
        ),
      );
    }
    for (int i = 0; i < widget.blockCount; i++) {
      final double fadeOutStart = 0.5 + i * unit;
      final double fadeOutEnd = fadeOutStart + unit;
      _fadeOuts.add(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(fadeOutStart, fadeOutEnd, curve: Curves.easeOut),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate((widget.blockCount), (index) {
        return AnimatedBuilder(
          animation: Listenable.merge([_fadeIns[index], _fadeOuts[index]]),
          builder: (context, child) {
            final opacity =
                _fadeIns[index].value * (1 - _fadeOuts[index].value);
            return Opacity(opacity: opacity.clamp(0.0, 1.0), child: child);
          },
          child: Container(height: 10, width: 10, color: Colors.blue),
        );
      }),
    );
  }
}

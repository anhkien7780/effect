import 'package:effect/ui/animation_playground/widgets/wave_blocks.dart';
import 'package:flutter/material.dart';

class Playground extends StatelessWidget {
  const Playground({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WaveBlocks(animationDuration: Duration(seconds: 3), blockCount: 20),
    );
  }
}

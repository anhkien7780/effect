import 'dart:math';

import 'package:effect/ui/animation_playground/widgets/wave_container.dart';
import 'package:flutter/material.dart';

class Playground extends StatelessWidget {
  const Playground({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return MaterialApp(home: WaveContainer(screenSize: screenSize));
  }
}
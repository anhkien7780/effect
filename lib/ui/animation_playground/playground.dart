import 'package:effect/ui/animation_playground/widgets/circle_loading.dart';
import 'package:flutter/material.dart';

class Playground extends StatelessWidget {
  const Playground({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CircleLoading(circleSize: Size(200, 200)));
  }
}

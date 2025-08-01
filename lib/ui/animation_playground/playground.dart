import 'package:flutter/material.dart';

class Playground extends StatelessWidget {
  const Playground({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WaveBlocks());
  }
}

class WaveBlocks extends StatefulWidget {
  const WaveBlocks({super.key});

  @override
  State<WaveBlocks> createState() => _WaveBlocksState();
}

class _WaveBlocksState extends State<WaveBlocks>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: List.generate(3, (index) {
            return Row(
              children: List.generate(3, (index) {
                return Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(color: Colors.blue, width: 50, height: 50),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}

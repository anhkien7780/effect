import 'package:effect/ui/shimmer_loading_app/widgets/card_list_item.dart';
import 'package:effect/ui/shimmer_loading_app/widgets/circle_list_item.dart';
import 'package:effect/ui/shimmer_loading_app/widgets/shimmer.dart';
import 'package:effect/ui/shimmer_loading_app/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class ShimmerLoadingApp extends StatefulWidget {
  const ShimmerLoadingApp({super.key});

  @override
  State<ShimmerLoadingApp> createState() => _ShimmerLoadingAppState();
}

class _ShimmerLoadingAppState extends State<ShimmerLoadingApp> {
  bool _isLoading = true;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _toggleLoading();
        },
        child: Icon(_isLoading ? Icons.hourglass_full : Icons.hourglass_bottom),
      ),
      body: Shimmer(
        linearGradient: _shimmerGradient,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(7, (context) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: ShimmerLoading(
                      isLoading: _isLoading,
                      child: CircleListItem(),
                    ),
                  );
                }),
              ),
            ),
            ...List.generate(4, (context) {
              return ShimmerLoading(
                isLoading: _isLoading,
                child: CardListItem(isLoading: _isLoading),
              );
            }),
          ],
        ),
      ),
    );
  }
}

const _shimmerGradient = LinearGradient(
  colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
  stops: [0.1, 0.3, 0.4],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);



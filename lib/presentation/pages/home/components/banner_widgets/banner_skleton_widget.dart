import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BannerSkeletonWidget extends StatelessWidget {
  const BannerSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: index == 0 ? 30 : 8,
                height: 8,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

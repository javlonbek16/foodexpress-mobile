import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantsSkletonWidget extends StatelessWidget {
  const RestaurantsSkletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(width: 180, height: 20, color: Colors.white),
          const SizedBox(height: 10),

          SizedBox(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 3,
              separatorBuilder: (_, _) => const SizedBox(width: 16),
              itemBuilder: (_, _) {
                return Container(
                  width: 285,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

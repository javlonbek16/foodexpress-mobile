import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/image_widget.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantDetailSkletonWidget extends StatelessWidget {
  const RestaurantDetailSkletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: ImageWidget(image: ""),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  "loading ... ",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 4),
                    Text(
                      "loading ... ",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Text("loading ... ", style: TextStyle(color: Colors.grey.shade600, height: 1.5)),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FoodCardWidget extends StatelessWidget {
  const FoodCardWidget({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.duration,
    this.onTap,
    this.onAdd,
  });

  final String name;
  final String image;
  final String price;
  final double rating;
  final String duration;

  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 1.5,
      shadowColor: Colors.black.withValues(alpha: .08),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                      child: Image.network(image, fit: BoxFit.cover),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .95),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite_border, size: 18),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 18),

                        const SizedBox(width: 3),

                        Text(
                          rating.toString(),
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                        ),

                        const Spacer(),

                        Icon(Icons.schedule_outlined, size: 16, color: Colors.grey.shade600),

                        const SizedBox(width: 4),

                        Text(duration, style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                      ],
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            price,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),

                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: onAdd,
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.add, color: Colors.white, size: 22),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

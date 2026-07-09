import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/core/extensions/price_extension.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/image_widget.dart';

class FoodCardWidget extends StatelessWidget {
  const FoodCardWidget({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.duration,
    required this.quantity,
    this.onTap,
    this.onAdd,
    this.onRemove,
  });

  final String name;
  final String image;
  final String price;
  final String duration;
  final int quantity;

  final VoidCallback? onTap;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

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
              flex: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: ImageWidget(image: image),
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
                            double.parse(price).formattedPrice,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),

                    quantity == 0
                        ? SizedBox(
                            width: double.infinity,
                            child: FilledButton(onPressed: onAdd, child: const Text('Add to Cart')),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: onRemove, icon: Icon(Icons.remove)),
                              ElevatedButton(onPressed: () {}, child: Text(quantity.toString())),
                              IconButton(onPressed: onAdd, icon: Icon(Icons.add)),
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

import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/infrastructure/extensions/price_extension.dart';
import 'package:foodexpress_mobile/presentation/pages/home/components/image_widget.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    this.onAdd,
    this.onRemove,
    this.onDelete,
  });

  final String name;
  final String image;
  final String price;
  final int quantity;

  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final totalPrice = (double.parse(price) * quantity).formattedPrice;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(width: 90, height: 90, child: ImageWidget(image: image)),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: SizedBox(
                height: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),

                        IconButton(
                          onPressed: onDelete,
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                        ),
                      ],
                    ),

                    Text(
                      double.parse(price).formattedPrice,
                      style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        _QuantityButton(icon: Icons.remove, onTap: onRemove),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            quantity.toString(),
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),

                        _QuantityButton(icon: Icons.add, onTap: onAdd),

                        const Spacer(),
                      ],
                    ),
                    Text(
                      totalPrice,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
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

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: SizedBox(width: 34, height: 34, child: Icon(icon, color: Colors.white, size: 20)),
      ),
    );
  }
}

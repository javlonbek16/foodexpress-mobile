import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_item_model.dart';

class FoodDetailsBottomSheet extends StatefulWidget {
  final String imageUrl;
  final MenuItemModel food;

  const FoodDetailsBottomSheet({super.key, required this.imageUrl, required this.food});

  @override
  State<FoodDetailsBottomSheet> createState() => _FoodDetailsBottomSheetState();
}

class _FoodDetailsBottomSheetState extends State<FoodDetailsBottomSheet> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .55,
      maxChildSize: .9,
      minChildSize: .5,
      expand: false,
      builder: (context, controller) {
        return Container(
          padding: EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: ListView(
            controller: controller,
            padding: EdgeInsets.zero,

            children: [
              const SizedBox(height: 10),

              Center(
                child: Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(widget.imageUrl, height: 220, fit: BoxFit.cover),
              ),

              const SizedBox(height: 20),

              Text(
                widget.food.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange),

                  SizedBox(width: 5),

                  Text("4.8"),

                  Spacer(),

                  Text(
                    "\$12.99",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Text(widget.food.description),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),

                      Text("$quantity"),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),

              // const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}

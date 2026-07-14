import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_event.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_state.dart';
import 'package:foodexpress_mobile/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mening savatim"),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.cartItems.isEmpty) {
                return const SizedBox.shrink();
              }

              return IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () async {
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text("Savatni tozalash"),
                        content: const Text(
                          "Rostdan ham savatdagi barcha narsalarni tozalamoqchimisiz?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              dialogContext.pop(false);
                            },
                            child: const Text("Bekor qilish"),
                          ),
                          FilledButton(
                            onPressed: () {
                              dialogContext.pop(true);
                            },
                            child: const Text("Tozalash"),
                          ),
                        ],
                      );
                    },
                  );

                  if (result == true && context.mounted) {
                    context.read<CartBloc>().add(CartCleared());
                  }
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Sizning savatingizda hech narsa yo'q!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text("Savatizni to'ldiring.", style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              const Text(
                "Savatdagi mahsulotlar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Card(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = state.cartItems[index];

                    return CartItemCard(
                      name: item.name,
                      image: item.image,
                      price: item.price.toString(),
                      quantity: item.quantity,
                      onRemove: () {
                        context.read<CartBloc>().add(
                          CartItemQuantityChanged(item.menuItemId, item.quantity - 1),
                        );
                      },
                      onAdd: () {
                        context.read<CartBloc>().add(CartItemAdded(item));
                      },
                      onDelete: () {
                        context.read<CartBloc>().add(CartItemRemoved(item.menuItemId));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

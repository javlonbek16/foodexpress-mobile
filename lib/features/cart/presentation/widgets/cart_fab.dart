import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/core/extensions/price_extension.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_state.dart';

class CartFab extends StatelessWidget {
  final VoidCallback onPressed;

  const CartFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.cartItems.isEmpty) {
          return const SizedBox.shrink();
        }

        final restaurantName = state.cartItems.first.name;

        final totalItems = state.cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

        final totalPrice = state.cartItems.fold<double>(
          0,
          (sum, item) => sum + item.price * item.quantity,
        );

        return FloatingActionButton.extended(
          onPressed: onPressed,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_cart),

              Positioned(
                right: -6,
                top: -6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Text(
                    totalItems.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          label: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(restaurantName, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(totalPrice.formattedPrice, style: const TextStyle(fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}

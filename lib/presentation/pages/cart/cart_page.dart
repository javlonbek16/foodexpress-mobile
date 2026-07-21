import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/auth/auth_bloc.dart';
import 'package:foodexpress_mobile/application/auth/auth_state.dart';
import 'package:foodexpress_mobile/application/cart/cart_bloc.dart';
import 'package:foodexpress_mobile/application/cart/cart_event.dart';
import 'package:foodexpress_mobile/application/cart/cart_state.dart';
import 'package:foodexpress_mobile/presentation/pages/cart/cart_widgets/cart_item_card.dart';
import 'package:foodexpress_mobile/presentation/pages/cart/cart_widgets/dialogs_widget.dart';
import 'package:foodexpress_mobile/application/order/order_bloc.dart';
import 'package:foodexpress_mobile/application/order/order_event.dart';
import 'package:foodexpress_mobile/application/order/order_state.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state.isLoading) {
          DialogsWidget.showLoadingDialog(context);
        }

        if (state.isOrderCreated) {
          Navigator.of(context, rootNavigator: true).pop();

          context.read<CartBloc>().add(CartCleared());

          DialogsWidget.showSuccessDialog(context);
        }

        if (state.error!.isNotEmpty) {
          Navigator.of(context, rootNavigator: true).pop();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error ?? "Xatolik")));
        }
      },
      child: Scaffold(
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
                          content: const Text("Rostdan ham savatdagi barcha narsalarni tozalamoqchimisiz?"),
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
                const Text("Savatdagi mahsulotlar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

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
                            CartItemQuantityChanged(item.menuItemId.toString(), item.quantity - 1),
                          );
                        },
                        onAdd: () {
                          context.read<CartBloc>().add(CartItemQuantityChanged(item.menuItemId, item.quantity + 1));
                        },
                        onDelete: () {
                          context.read<CartBloc>().add(CartItemRemoved(item.menuItemId));
                        },
                      );
                    },
                  ),
                ),
                FilledButton(
                  onPressed: state.cartItems.isEmpty
                      ? null
                      : () {
                          final userState = context.read<AuthBloc>().state;

                          if (userState is Authenticated) {
                            context.read<OrderBloc>().add(
                              CreateOrder(
                                cartItems: state.cartItems,
                                restaurantName: "Noma'lum restoran",
                                currency: "UZS",
                                deliveryAddress: "Sodiq Azimov 63A",
                                customerFullName: userState.user.name,
                              ),
                            );
                          }
                        },
                  child: const Text("Buyurtma qilish"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

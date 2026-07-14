import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/core/utils/app_text_styles.dart';
import 'package:foodexpress_mobile/features/cart/data/models/cart_item_model.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_event.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_bloc.dart';

import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/food_card_widget.dart';
import 'package:go_router/go_router.dart';

class RestaurantMenuSection extends StatelessWidget {
  final String restaurantId;
  const RestaurantMenuSection({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantMenuBloc, RestaurantMenuState>(
      builder: (context, restaurantMenuState) {
        if (restaurantMenuState.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (restaurantMenuState.error != null) {
          return Center(child: Text(restaurantMenuState.error.toString()));
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Menu", style: AppTextStyles.h2),
                Text(
                  restaurantMenuState.food.length.toString(),
                  style: AppTextStyles.bodySmall.copyWith(fontSize: 16),
                ),
              ],
            ),

            restaurantMenuState.food.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Menuda hech narsa yo'q",
                        style: AppTextStyles.bodySmall.copyWith(fontSize: 16),
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 12),
                    itemCount: restaurantMenuState.food.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: .55,
                    ),
                    itemBuilder: (context, index) {
                      final food = restaurantMenuState.food[index];
                      return BlocSelector<CartBloc, CartState, int>(
                        selector: (state) {
                          return state.quantityOf(food.id.toString());
                        },
                        builder: (context, quantity) {
                          final cart = CartItemModel(
                            menuItemId: food.id.toString(),
                            restaurantId: restaurantId,
                            name: food.name,
                            image: food.imageUrl,
                            price: double.parse(food.price),
                            quantity: 1,
                          );
                          return FoodCardWidget(
                            name: food.name,
                            image: food.imageUrl,
                            price: food.price,
                            duration: food.deliveryTime,
                            quantity: quantity,
                            onTap: () {},
                            onAdd: () async {
                              final cartState = context.read<CartBloc>().state;

                              if (cartState.cartItems.isEmpty) {
                                context.read<CartBloc>().add(CartItemAdded(cart));
                                return;
                              }

                              final currentRestaurantId = cartState.cartItems.first.restaurantId;

                              if (currentRestaurantId == restaurantId) {
                                context.read<CartBloc>().add(CartItemAdded(cart));
                                return;
                              }

                              final shouldReplace = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text(
                                    "Boshqa restoran mahsulotini qo'shmoqchimisiz?",
                                  ),
                                  content: const Text(
                                    "Savatizda boshqa restoran mahsuloti bor. Yangi mahsulot qo'shish uchun avval uni tozalang",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => context.pop(false),
                                      child: const Text("Bekor qilish"),
                                    ),
                                    FilledButton(
                                      onPressed: () => context.pop(true),
                                      child: const Text("Tozalash va qo'shish"),
                                    ),
                                  ],
                                ),
                              );

                              if (shouldReplace == true && context.mounted) {
                                context.read<CartBloc>().add(CartReplaceRequested(cart));
                              }
                            },
                            onRemove: () {
                              context.read<CartBloc>().add(
                                CartItemQuantityChanged(food.id.toString(), quantity - 1),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
          ],
        );
      },
    );
  }
}

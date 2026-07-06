import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_bloc.dart';

import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/food_card_widget.dart';

class RestaurantMenuSection extends StatelessWidget {
  const RestaurantMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantMenuBloc, RestaurantMenuState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.error != null) {
          return Center(child: Text(state.error.toString()));
        }
        final foods = state.menus.expand((element) => element.items).toList();
        print("menus = ${state.menus.length}");
        print("foods = ${foods.length}");
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Menu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                Text(foods.length.toString(), style: TextStyle(color: Colors.grey)),
              ],
            ),

            state.menus.isEmpty
                ? Center(child: Text("Menuda hech narsa yo'q"))
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 12),
                    itemCount: foods.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: .55,
                    ),
                    itemBuilder: (context, index) {
                      final food = foods[index];
                      return FoodCardWidget(
                        name: food.name,
                        image: food.imageUrl,
                        price: "${food.price} so'm",
                        rating: 4.8,
                        duration: food.deliveryTime,
                        onTap: () {},
                        onAdd: () {},
                      );
                    },
                  ),
          ],
        );
      },
    );
  }
}

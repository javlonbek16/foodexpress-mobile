import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_state.dart';

import 'package:foodexpress_mobile/features/home/presentation/widgets/restaurant_widgets/menu_category_widget.dart';

class RestaurantMenuCategoryWidget extends StatelessWidget {
  const RestaurantMenuCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantMenuBloc, RestaurantMenuState>(
      builder: (context, state) {
        return SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final category = state.categories[index];
              return MenuCategoryWidget(
                category: category,
                onTap: () {
                  context.read<RestaurantMenuBloc>().add(
                    RestaurantMenuCategoryChanged(
                      restaurantId: category.restaurantId,
                      categoryName: category.name,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

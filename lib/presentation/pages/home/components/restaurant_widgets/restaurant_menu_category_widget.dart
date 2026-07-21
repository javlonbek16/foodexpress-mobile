import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/category/category_bloc.dart';
import 'package:foodexpress_mobile/application/category/category_state.dart';
import 'package:foodexpress_mobile/application/restaurant_menu/restaurant_menu_bloc.dart';
import 'package:foodexpress_mobile/application/restaurant_menu/restaurant_menu_event.dart';
import 'package:foodexpress_mobile/presentation/pages/home/components/category_widgets/general_category_widget.dart';

class RestaurantMenuCategoryWidget extends StatelessWidget {
  final String restaurantId;

  const RestaurantMenuCategoryWidget({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        final menuState = context.watch<RestaurantMenuBloc>().state;
        return SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.menuCategories.length + 1,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (index == 0) {
                return CategoryChip(
                  title: "All",
                  isSelected: menuState.selectedCategory == null,
                  onTap: () {
                    context.read<RestaurantMenuBloc>().add(RestaurantMenuFetched(restaurantId));
                  },
                );
              }

              final category = state.menuCategories[index - 1];
              final isSelected = menuState.selectedCategory == category.name;
              return CategoryChip(
                title: category.name,
                isSelected: isSelected,
                onTap: () {
                  context.read<RestaurantMenuBloc>().add(
                    RestaurantMenuCategoryChanged(restaurantId: restaurantId, categoryName: category.name),
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

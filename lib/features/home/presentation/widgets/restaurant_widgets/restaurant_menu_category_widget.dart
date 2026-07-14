import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/category_widgets/general_category_widget.dart';

 

class RestaurantMenuCategoryWidget extends StatelessWidget {
  final String restaurantId;
  const RestaurantMenuCategoryWidget({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantMenuBloc, RestaurantMenuState>(
      builder: (context, state) {
        return SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length + 1,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (index == 0) {
                return CategoryChip(
                  title: "All",
                  isSelected: state.selectedCategory == null,
                  onTap: () {
                    context.read<RestaurantMenuBloc>().add(RestaurantMenuFetched(restaurantId));
                  },
                );
              }
              final category = state.categories[index - 1];
              final isSelected = state.selectedCategory == category.name;
              return CategoryChip(
                title: category.name,
                isSelected: isSelected,
                onTap: () {
                  context.read<RestaurantMenuBloc>().add(
                    RestaurantMenuCategoryChanged(
                      restaurantId: restaurantId,
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

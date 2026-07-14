import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/core/utils/app_text_styles.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/category_widgets/category_skleton_widget.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/category_widgets/general_category_widget.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, restaurantState) {
        return BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state.isLoading) {
              // return Center(child: CircularProgressIndicator());
              return CategorySkletonWidget();
            }
            if (state.error != null) {
              return Center(child: Text(state.error!));
            }
            return Column(
              children: [
                const ListTile(
                  title: Text("Kategoriyalar", style: AppTextStyles.h3),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 10),

                SizedBox(
                  height: 52,
                  child: state.categories.isEmpty
                      ? const Center(
                          child: Text("Kategoriyalar topilmadi", style: AppTextStyles.titleMedium),
                        )
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length + 1,
                          separatorBuilder: (_, _) => const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return CategoryChip(
                                title: "All",
                                isSelected: restaurantState.selectedCategory == null,
                                onTap: () {
                                  context.read<RestaurantBloc>().add(RestaurantFetched());
                                },
                              );
                            }
                            final category = state.categories[index - 1];
                            final isSelected =
                                restaurantState.selectedCategory == category.categoryName;
                            return CategoryChip(
                              isSelected: isSelected,
                              title: category.categoryName,
                              onTap: () {
                                context.read<RestaurantBloc>().add(
                                  RestaurantCategoryChanged(category.categoryName),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

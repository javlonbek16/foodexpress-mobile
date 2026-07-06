import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/category_widgets/general_category_widget.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.error != null) {
          return Center(child: Text(state.error!));
        }
        return Column(
          children: [
            const ListTile(
              title: Text(
                "Kategoriyalar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 52,
              child: state.categories.isEmpty
                  ? const Center(child: Text("Kategoriyalar topilmadi"))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return GeneralCategoryWidget(
                          category: category,
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
  }
}

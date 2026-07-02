import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/general_category_widget.dart';

class CategorySection extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategorySection({super.key, required this.categories});

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
              child: categories.isEmpty
                  ? const Center(child: Text("Kategoriyalar topilmadi"))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GeneralCategoryWidget(category: category);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

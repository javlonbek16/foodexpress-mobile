import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';

class GeneralCategoryWidget extends StatelessWidget {
  final CategoryModel category;
  const GeneralCategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Text(
              category.categoryName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

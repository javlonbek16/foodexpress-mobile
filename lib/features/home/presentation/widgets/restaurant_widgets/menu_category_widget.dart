import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_category_model.dart';

class MenuCategoryWidget extends StatelessWidget {
  final MenuCategoryModel category;
  final void Function()? onTap;
  const MenuCategoryWidget({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

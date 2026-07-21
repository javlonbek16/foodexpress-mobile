import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/presentation/assets/res/app_colors.dart';
import 'package:foodexpress_mobile/presentation/assets/res/app_text_styles.dart';

class CategoryChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryChip({super.key, required this.title, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.categorySelected : AppColors.categoryUnselected,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Center(
            child: Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                fontSize: 15,
                color: isSelected ? AppColors.categorySelectedText : AppColors.categoryUnselectedText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

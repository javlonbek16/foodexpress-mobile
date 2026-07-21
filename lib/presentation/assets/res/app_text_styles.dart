import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  /// Display
  static const displayLarge = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const displayMedium = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  /// Headings

  static const h1 = TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.25);

  static const h2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.3);

  static const h3 = TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.3);

  /// Titles

  static const titleLarge = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  static const titleMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  static const titleSmall = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  /// Body

  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  /// Labels

  static const labelLarge = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  static const labelMedium = TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary);

  static const labelSmall = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textHint);

  /// Buttons

  static const button = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);

  /// Price

  static const price = TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary);

  static const oldPrice = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
    decoration: TextDecoration.lineThrough,
  );

  /// Restaurant

  static const restaurantName = TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  static const restaurantInfo = TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary);

  /// Category

  static const category = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  /// Input

  static const input = TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textPrimary);

  static const hint = TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.textHint);

  /// Status

  static const status = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
}

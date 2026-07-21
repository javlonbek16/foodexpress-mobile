import 'package:foodexpress_mobile/infrastructure/models/category/category_model.dart';
import 'package:foodexpress_mobile/infrastructure/models/category/menu_category_model.dart';

class CategoryState {
  final bool isLoading;
  final List<CategoryModel> categories;
  final List<MenuCategoryModel> menuCategories;
  final String? error;

  const CategoryState({this.isLoading = false, this.categories = const [], this.menuCategories = const [], this.error});

  CategoryState copyWith({
    bool? isLoading,
    List<CategoryModel>? categories,
    List<MenuCategoryModel>? menuCategories,
    String? error,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      menuCategories: menuCategories ?? this.menuCategories,
      error: error,
    );
  }
}

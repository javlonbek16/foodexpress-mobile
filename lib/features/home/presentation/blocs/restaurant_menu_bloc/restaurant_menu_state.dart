import 'package:foodexpress_mobile/features/home/data/models/menu_category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_item_model.dart';

class RestaurantMenuState {
  final bool isLoading;
  final List<MenuCategoryModel> categories;
  final List<MenuItemModel> food;
  final String? selectedCategory;
  final String? error;

  const RestaurantMenuState({
    this.isLoading = false,
    this.categories = const [],
    this.food = const [],
    this.selectedCategory,
    this.error,
  });

  RestaurantMenuState copyWith({
    bool? isLoading,
    List<MenuCategoryModel>? categories,
    List<MenuItemModel>? food,
    String? selectedCategory,
    String? error,
  }) {
    return RestaurantMenuState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      food: food ?? this.food,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      error: error,
    );
  }
}

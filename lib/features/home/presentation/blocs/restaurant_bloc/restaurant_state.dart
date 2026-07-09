import 'package:foodexpress_mobile/features/home/data/models/restaurant_model.dart';

class RestaurantState {
  final bool isLoading;
  final List<RestaurantModel> restaurants;
  final String? selectedCategory;
  final String? error;

  const RestaurantState({
    this.isLoading = false,
    this.restaurants = const [],
    this.selectedCategory,
    this.error,
  });

  RestaurantState copyWith({
    bool? isLoading,
    List<RestaurantModel>? restaurants,
    String? selectedCategory,
    String? error,
  }) {
    return RestaurantState(
      isLoading: isLoading ?? this.isLoading,
      restaurants: restaurants ?? this.restaurants,
      selectedCategory: selectedCategory,
      error: error,
    );
  }
}

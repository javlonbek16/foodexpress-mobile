import 'package:foodexpress_mobile/infrastructure/models/restaurant/restaurant_model.dart';

class RestaurantDetailState {
  final bool isLoading;
  final RestaurantModel? restaurant;
  final String? error;

  const RestaurantDetailState({this.isLoading = false, this.restaurant, this.error});

  RestaurantDetailState copyWith({bool? isLoading, RestaurantModel? restaurant, String? error}) {
    return RestaurantDetailState(
      isLoading: isLoading ?? this.isLoading,
      restaurant: restaurant ?? this.restaurant,
      error: error ?? this.error,
    );
  }
}

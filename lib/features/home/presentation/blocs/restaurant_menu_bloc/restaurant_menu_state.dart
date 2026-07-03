import 'package:foodexpress_mobile/features/home/data/models/restaurant_menu_item_model.dart';

class RestaurantMenuState {
  final bool isLoading;
  final List<RestaurantMenuItemModel> menus;
  final String? error;

  const RestaurantMenuState({this.isLoading = false, this.menus = const [], this.error});

  RestaurantMenuState copyWith({
    bool? isLoading,
    List<RestaurantMenuItemModel>? menus,
    String? error,
  }) {
    return RestaurantMenuState(
      isLoading: isLoading ?? this.isLoading,
      menus: menus ?? this.menus,
      error: error,
    );
  }
}

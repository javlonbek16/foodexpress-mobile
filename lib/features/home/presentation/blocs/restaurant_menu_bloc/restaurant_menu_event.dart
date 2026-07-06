abstract class RestaurantMenuEvent {}

class RestaurantMenuFetched extends RestaurantMenuEvent {
  final String id;

  RestaurantMenuFetched(this.id);
}

class RestaurantMenuCategoryChanged extends RestaurantMenuEvent {
  final String restaurantId;
  final String categoryName;

  RestaurantMenuCategoryChanged({required this.restaurantId, required this.categoryName});
}

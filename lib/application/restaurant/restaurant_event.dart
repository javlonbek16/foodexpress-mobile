abstract class RestaurantEvent {}

class RestaurantFetched extends RestaurantEvent {}

class RestaurantCategoryChanged extends RestaurantEvent {
  final String categoryName;

  RestaurantCategoryChanged(this.categoryName);
}

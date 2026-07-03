abstract class RestaurantMenuEvent {}

class RestaurantMenuFetched extends RestaurantMenuEvent {
  final String id;

  RestaurantMenuFetched(this.id);
}

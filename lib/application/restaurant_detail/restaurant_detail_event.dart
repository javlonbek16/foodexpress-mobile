abstract class RestaurantDetailEvent {}

class RestaurantDetailFetched extends RestaurantDetailEvent {
  final String id;

  RestaurantDetailFetched(this.id);
}

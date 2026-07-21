abstract class CategoryEvent {}

class CategoryFetched extends CategoryEvent {}

class MenuCategoryFetched extends CategoryEvent {
  final String restaurantId;

  MenuCategoryFetched(this.restaurantId);
}

import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/infrastructure/models/restaurant/menu_item_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class RestaurantMenuRepository {
  Future<Either<AppFailures, List<MenuItemModel>>> getMenuItemsByRestaurant(String id);

  Future<Either<AppFailures, List<MenuItemModel>>> getMenuItemsByCategory(String restaurantId, String categoryName);
}

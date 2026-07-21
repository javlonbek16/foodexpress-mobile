import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/domain/services/restaurant_menu/repository/restaurant_menu_repository.dart';
import 'package:foodexpress_mobile/domain/services/restaurant_menu/restaurant_menu_api_service.dart';
import 'package:foodexpress_mobile/infrastructure/models/restaurant/menu_item_model.dart';
import 'package:fpdart/fpdart.dart';

class RestaurantMenuRepositoryImpl implements RestaurantMenuRepository {
  final RestaurantMenuApiService apiService;

  RestaurantMenuRepositoryImpl(this.apiService);

  @override
  Future<Either<AppFailures, List<MenuItemModel>>> getMenuItemsByCategory(String restaurantId, String categoryName) {
    return apiService.getMenuItemsByCategory(restaurantId, categoryName);
  }

  @override
  Future<Either<AppFailures, List<MenuItemModel>>> getMenuItemsByRestaurant(String id) {
    return apiService.getMenuItemsByRestaurant(id);
  }
}

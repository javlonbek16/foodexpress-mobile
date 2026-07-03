import 'package:foodexpress_mobile/features/home/data/models/banner_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_model.dart';

abstract class HomeRepository {
  Future<List<BannerModel>> getBanners();

  Future<List<CategoryModel>> getCategories();

  Future<List<MenuItemModel>> getMenuItems();

  Future<List<RestaurantModel>> getRestaurants();

  Future<RestaurantModel> getRestaurantById(String id);

  Future<List<RestaurantMenuItemModel>> getMenuItemsByRestaurant(String id);
}

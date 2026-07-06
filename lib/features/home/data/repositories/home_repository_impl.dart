import 'package:foodexpress_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:foodexpress_mobile/features/home/data/models/banner_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_model.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl(this.homeRemoteDataSource);

  @override
  Future<List<BannerModel>> getBanners() async {
    return await homeRemoteDataSource.getBanners();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    return await homeRemoteDataSource.getCategories();
  }

  @override
  Future<List<MenuItemModel>> getMenuItems() async {
    return await homeRemoteDataSource.getMenuItems();
  }

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    return await homeRemoteDataSource.getRestaurants();
  }

  @override
  Future<RestaurantModel> getRestaurantById(String id) async {
    return await homeRemoteDataSource.getRestaurantById(id);
  }

  @override
  Future<List<MenuItemModel>> getMenuItemsByRestaurant(String id) async {
    return await homeRemoteDataSource.getMenuItemsByRestaurant(id);
  }

  @override
  Future<List<RestaurantModel>> getRestaurantsByCategory(String categoryName) async {
    return await homeRemoteDataSource.getRestaurantsByCategory(categoryName);
  }

  @override
  Future<List<MenuCategoryModel>> getMenuCategoryByRestaurant(String restaurantId) {
    return homeRemoteDataSource.getMenuCategoryByRestaurant(restaurantId);
  }

  @override
  Future<List<MenuItemModel>> getMenuItemsByCategory(
    String restaurantId,
    String categoryName,
  ) async {
    return await homeRemoteDataSource.getMenuItemsByCategory(restaurantId, categoryName);
  }
}

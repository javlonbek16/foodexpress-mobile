import 'package:foodexpress_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_model.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl(this.homeRemoteDataSource);

  @override
  Future<List<CategoryModel>> getCategories() async {
    return await homeRemoteDataSource.getCategories();
  }

  @override
  Future<CategoryModel> getCategoryById(int id) async {
    return await homeRemoteDataSource.getCategoryById(id);
  }

  @override
  Future<List<MenuItemModel>> getMenuItems() async {
    return await homeRemoteDataSource.getMenuItems();
  }

  @override
  Future<MenuItemModel> getMenuItemById(int id) async {
    return await homeRemoteDataSource.getMenuItemById(id);
  }

  @override
  Future<List<RestaurantModel>> getRestaurant() async {
    return await homeRemoteDataSource.getRestaurants();
  }

  @override
  Future<RestaurantModel> getRestaurantById(String id) async {
    return await homeRemoteDataSource.getRestaurantById(id);
  }
}

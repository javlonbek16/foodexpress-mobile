import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/core/network/dio_client.dart';
import 'package:foodexpress_mobile/core/network/network_executor.dart';
import 'package:foodexpress_mobile/features/home/data/models/banner_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_model.dart';

class HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSource(DioClient client) : dio = client.dio;

  Future<List<BannerModel>> getBanners() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get("/api/ads");

      return (response.data as List).map((e) => BannerModel.fromJson(e)).toList();
    });
  }

  Future<List<CategoryModel>> getCategories() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get("/api/general-category");

      return (response.data as List).map((e) => CategoryModel.fromJson(e)).toList();
    });
  }

  Future<List<MenuItemModel>> getMenuItems() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get("/api/menu-items");

      return (response.data as List).map((e) => MenuItemModel.fromJson(e)).toList();
    });
  }

  Future<List<RestaurantModel>> getRestaurants() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get("/api/restaurants");

      return (response.data as List).map((e) => RestaurantModel.fromJson(e)).toList();
    });
  }

  Future<RestaurantModel> getRestaurantById(String id) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get("/api/restaurant/$id");

      return RestaurantModel.fromJson(response.data);
    });
  }

  Future<List<RestaurantMenuItemModel>> getMenuItemsByRestaurant(String id) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(
        "/api/restaurants/$id/menu-items",
        options: Options(extra: {"requiresToken": false}),
      );

      return (response.data as List).map((e) => RestaurantMenuItemModel.fromJson(e)).toList();
    });
  }
}

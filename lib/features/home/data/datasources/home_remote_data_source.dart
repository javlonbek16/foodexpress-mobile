import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/core/constants/app_endpoints.dart';
import 'package:foodexpress_mobile/core/network/dio_client.dart';
import 'package:foodexpress_mobile/core/network/network_executor.dart';
import 'package:foodexpress_mobile/features/home/data/models/banner_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_category_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/menu_item_model.dart';
import 'package:foodexpress_mobile/features/home/data/models/restaurant_model.dart';

class HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSource(DioClient client) : dio = client.dio;

  Future<List<BannerModel>> getBanners() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(AppEndpoints.bannerApi);

      return (response.data as List).map((e) => BannerModel.fromJson(e)).toList();
    });
  }

  Future<List<CategoryModel>> getCategories() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(AppEndpoints.generalCategoryApi);

      return (response.data as List).map((e) => CategoryModel.fromJson(e)).toList();
    });
  }

  Future<List<MenuItemModel>> getMenuItems() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(AppEndpoints.menuItemsApi);

      return (response.data as List).map((e) => MenuItemModel.fromJson(e)).toList();
    });
  }

  Future<List<RestaurantModel>> getRestaurants() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(AppEndpoints.restaurantsApi);

      return (response.data as List).map((e) => RestaurantModel.fromJson(e)).toList();
    });
  }

  Future<RestaurantModel> getRestaurantById(String id) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(AppEndpoints.restaurantByIdApi(id));

      return RestaurantModel.fromJson(response.data);
    });
  }

  Future<List<MenuItemModel>> getMenuItemsByRestaurant(String id) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(
        AppEndpoints.menuItemsByRestaurantApi(id),
        options: Options(extra: {"requiresToken": false}),
      );

      return (response.data as List).map((e) => MenuItemModel.fromJson(e)).toList();
    });
  }

  Future<List<RestaurantModel>> getRestaurantsByCategory(String categoryName) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(
        AppEndpoints.restaurantByCategoryApi(categoryName),
        options: Options(extra: {"requiresToken": false}),
      );

      return (response.data as List).map((e) => RestaurantModel.fromJson(e)).toList();
    });
  }

  Future<List<MenuCategoryModel>> getMenuCategoryByRestaurant(String restaurantId) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(
        AppEndpoints.menuCategoryApi(restaurantId),
        options: Options(extra: {"requiresToken": false}),
      );

      return (response.data as List).map((e) => MenuCategoryModel.fromJson(e)).toList();
    });
  }

  Future<List<MenuItemModel>> getMenuItemsByCategory(
    String restaurantId,
    String categoryName,
  ) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(
        AppEndpoints.menuItemsByCategoryApi(restaurantId, categoryName),
        options: Options(extra: {"requiresToken": false}),
      );

      return (response.data as List).map((e) => MenuItemModel.fromJson(e)).toList();
    });
  }
}

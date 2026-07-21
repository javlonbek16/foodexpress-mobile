import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/infrastructure/constants/app_endpoints.dart';
import 'package:foodexpress_mobile/infrastructure/network/dio_client.dart';
import 'package:foodexpress_mobile/infrastructure/network/network_executor.dart';
import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/infrastructure/models/restaurant/menu_item_model.dart';
import 'package:fpdart/fpdart.dart';

class RestaurantMenuApiService {
  final Dio dio;

  RestaurantMenuApiService(DioClient client) : dio = client.dio;

  Future<Either<AppFailures, List<MenuItemModel>>> getMenuItemsByRestaurant(String id) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(
        AppEndpoints.menuItemsByRestaurantApi(id),
        options: Options(extra: {"requiresToken": false}),
      );
      final data = response.data as List<dynamic>;

      return data.map((e) => MenuItemModel.fromJson(e)).toList();
    });
  }

  Future<Either<AppFailures, List<MenuItemModel>>> getMenuItemsByCategory(
    String restaurantId,
    String categoryName,
  ) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(
        AppEndpoints.menuItemsByCategoryApi(restaurantId, categoryName),
        options: Options(extra: {"requiresToken": false}),
      );
      final data = response.data as List<dynamic>;

      return data.map((e) => MenuItemModel.fromJson(e)).toList();
    });
  }
}

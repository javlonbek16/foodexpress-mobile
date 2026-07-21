import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/infrastructure/constants/app_endpoints.dart';
import 'package:foodexpress_mobile/infrastructure/network/dio_client.dart';
import 'package:foodexpress_mobile/infrastructure/network/network_executor.dart';
import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/infrastructure/models/restaurant/restaurant_model.dart';
import 'package:fpdart/fpdart.dart';

class RestaurantApiService {
  final Dio dio;

  RestaurantApiService(DioClient client) : dio = client.dio;

  Future<Either<AppFailures, List<RestaurantModel>>> getRestaurants() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(AppEndpoints.restaurantsApi);
      final data = response.data as List<dynamic>;

      return data.map((e) => RestaurantModel.fromJson(e)).toList();
    });
  }

  Future<Either<AppFailures, RestaurantModel>> getRestaurantById(String id) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(AppEndpoints.restaurantByIdApi(id));
      final data = response.data;

      return RestaurantModel.fromJson(data);
    });
  }

  Future<Either<AppFailures, List<RestaurantModel>>> getRestaurantsByCategory(String name) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(
        AppEndpoints.restaurantByCategoryApi(name),
        options: Options(extra: {"requiresToken": false}),
      );
      final data = response.data as List<dynamic>;

      return data.map((e) => RestaurantModel.fromJson(e)).toList();
    });
  }
}

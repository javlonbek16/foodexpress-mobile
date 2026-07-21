import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/infrastructure/constants/app_endpoints.dart';
import 'package:foodexpress_mobile/infrastructure/network/dio_client.dart';
import 'package:foodexpress_mobile/infrastructure/network/network_executor.dart';
import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/infrastructure/models/category/category_model.dart';
import 'package:foodexpress_mobile/infrastructure/models/category/menu_category_model.dart';
import 'package:fpdart/fpdart.dart';

class CategoryApiService {
  final Dio dio;

  CategoryApiService(DioClient client) : dio = client.dio;

  Future<Either<AppFailures, List<CategoryModel>>> getCategories() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(AppEndpoints.generalCategoryApi);
      final data = response.data as List<dynamic>;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    });
  }

  Future<Either<AppFailures, List<MenuCategoryModel>>> getMenuCategoryByRestaurant(String restaurantId) async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(
        AppEndpoints.menuCategoryApi(restaurantId),
        options: Options(extra: {"requiresToken": false}),
      );
      final data = response.data as List<dynamic>;
      return data.map((e) => MenuCategoryModel.fromJson(e)).toList();
    });
  }
}

import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/domain/services/restaurant/repository/restaurant_repository.dart';
import 'package:foodexpress_mobile/domain/services/restaurant/restaurant_api_service.dart';
import 'package:foodexpress_mobile/infrastructure/models/restaurant/restaurant_model.dart';
import 'package:fpdart/fpdart.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantApiService apiService;

  RestaurantRepositoryImpl(this.apiService);

  @override
  Future<Either<AppFailures, RestaurantModel>> getRestaurantById(String id) => apiService.getRestaurantById(id);

  @override
  Future<Either<AppFailures, List<RestaurantModel>>> getRestaurants() => apiService.getRestaurants();

  @override
  Future<Either<AppFailures, List<RestaurantModel>>> getRestaurantsByCategory(String name) =>
      apiService.getRestaurantsByCategory(name);
}

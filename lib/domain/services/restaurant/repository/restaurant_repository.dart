import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/infrastructure/models/restaurant/restaurant_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class RestaurantRepository {
  Future<Either<AppFailures, List<RestaurantModel>>> getRestaurants();

  Future<Either<AppFailures, RestaurantModel>> getRestaurantById(String id);

  Future<Either<AppFailures, List<RestaurantModel>>> getRestaurantsByCategory(String name);
}

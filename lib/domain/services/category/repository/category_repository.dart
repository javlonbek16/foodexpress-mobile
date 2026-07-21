import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/infrastructure/models/category/category_model.dart';
import 'package:foodexpress_mobile/infrastructure/models/category/menu_category_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoryRepository {
  Future<Either<AppFailures, List<CategoryModel>>> getCategories();

  Future<Either<AppFailures, List<MenuCategoryModel>>> getMenuCategoryByRestaurant(String restaurantId);
}

import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/domain/services/category/category_api_service.dart';
import 'package:foodexpress_mobile/domain/services/category/repository/category_repository.dart';
import 'package:foodexpress_mobile/infrastructure/models/category/category_model.dart';
import 'package:foodexpress_mobile/infrastructure/models/category/menu_category_model.dart';
import 'package:fpdart/fpdart.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryApiService apiService;

  CategoryRepositoryImpl(this.apiService);

  @override
  Future<Either<AppFailures, List<CategoryModel>>> getCategories() => apiService.getCategories();

  @override
  Future<Either<AppFailures, List<MenuCategoryModel>>> getMenuCategoryByRestaurant(String restaurantId) =>
      apiService.getMenuCategoryByRestaurant(restaurantId);
}

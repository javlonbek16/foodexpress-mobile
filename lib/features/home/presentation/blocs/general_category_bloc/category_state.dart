import 'package:foodexpress_mobile/features/home/data/models/category_model.dart';

class CategoryState {
  final bool isLoading;
  final List<CategoryModel> categories;
  final String? error;

  const CategoryState({this.isLoading = false, this.categories = const [], this.error});

  CategoryState copyWith({bool? isLoading, List<CategoryModel>? categories, String? error}) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      error: this.error,
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/domain/services/category/repository/category_repository.dart';
import 'package:foodexpress_mobile/application/category/category_event.dart';
import 'package:foodexpress_mobile/application/category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc(this.repository) : super(const CategoryState()) {
    on<CategoryFetched>(_onFetched);
    on<MenuCategoryFetched>(_onMenuCategoryFetched);
  }

  Future<void> _onFetched(CategoryFetched event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await repository.getCategories();

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error.message)),
      (categories) => emit(state.copyWith(isLoading: false, categories: categories)),
    );
  }

  Future<void> _onMenuCategoryFetched(MenuCategoryFetched event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await repository.getMenuCategoryByRestaurant(event.restaurantId);
    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error.message)),
      (menuCategories) => emit(state.copyWith(isLoading: false, menuCategories: menuCategories)),
    );
  }
}

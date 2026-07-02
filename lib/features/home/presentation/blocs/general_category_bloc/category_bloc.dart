import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final HomeRepository repository;

  CategoryBloc(this.repository) : super(const CategoryState()) {
    on<CategoryFetched>(_onFetched);
  }

  Future<void> _onFetched(CategoryFetched event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final categories = await repository.getCategories();

      emit(state.copyWith(isLoading: false, categories: categories));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}

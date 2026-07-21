import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/domain/services/category/repository/category_repository.dart';
import 'package:foodexpress_mobile/domain/services/restaurant_menu/repository/restaurant_menu_repository.dart';
import 'package:foodexpress_mobile/application/restaurant_menu/restaurant_menu_event.dart';
import 'package:foodexpress_mobile/application/restaurant_menu/restaurant_menu_state.dart';

class RestaurantMenuBloc extends Bloc<RestaurantMenuEvent, RestaurantMenuState> {
  final CategoryRepository categoryRepository;
  final RestaurantMenuRepository menuRepository;

  RestaurantMenuBloc(this.categoryRepository, this.menuRepository) : super(const RestaurantMenuState()) {
    on<RestaurantMenuFetched>(_onFetched);
    on<RestaurantMenuCategoryChanged>(_onChanged);
  }

  Future<void> _onFetched(RestaurantMenuFetched event, Emitter<RestaurantMenuState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, selectedCategory: null));

    final result = await menuRepository.getMenuItemsByRestaurant(event.id);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error.message)),
      (food) => emit(state.copyWith(isLoading: false, food: food, selectedCategory: null)),
    );
  }

  Future<void> _onChanged(RestaurantMenuCategoryChanged event, Emitter<RestaurantMenuState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, selectedCategory: event.categoryName));

    final result = await menuRepository.getMenuItemsByCategory(event.restaurantId, event.categoryName);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error.message)),
      (food) => emit(state.copyWith(isLoading: false, food: food, selectedCategory: event.categoryName)),
    );
  }
}

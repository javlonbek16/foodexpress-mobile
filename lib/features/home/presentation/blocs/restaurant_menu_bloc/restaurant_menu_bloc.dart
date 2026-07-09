import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_state.dart';

class RestaurantMenuBloc extends Bloc<RestaurantMenuEvent, RestaurantMenuState> {
  final HomeRepository repository;

  RestaurantMenuBloc(this.repository) : super(const RestaurantMenuState()) {
    on<RestaurantMenuFetched>(_onFetched);
    on<RestaurantMenuCategoryChanged>(_onChanged);
  }

  Future<void> _onFetched(RestaurantMenuFetched event, Emitter<RestaurantMenuState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, selectedCategory: null));

    try {
      final categories = await repository.getMenuCategoryByRestaurant(event.id);

      final foods = await repository.getMenuItemsByRestaurant(event.id);

      emit(
        state.copyWith(
          isLoading: false,
          categories: categories,
          food: foods,
          selectedCategory: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onChanged(
    RestaurantMenuCategoryChanged event,
    Emitter<RestaurantMenuState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, selectedCategory: event.categoryName));

    try {
      final menus = await repository.getMenuItemsByCategory(event.restaurantId, event.categoryName);

      emit(state.copyWith(isLoading: false, food: menus, selectedCategory: event.categoryName));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}

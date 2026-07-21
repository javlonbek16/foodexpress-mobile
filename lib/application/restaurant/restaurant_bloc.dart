import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/domain/services/restaurant/repository/restaurant_repository.dart';
import 'package:foodexpress_mobile/application/restaurant/restaurant_event.dart';
import 'package:foodexpress_mobile/application/restaurant/restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository repository;

  RestaurantBloc(this.repository) : super(const RestaurantState()) {
    on<RestaurantFetched>(_onFetched);
    on<RestaurantCategoryChanged>(_onChanged);
  }

  Future<void> _onFetched(RestaurantFetched event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, selectedCategory: null));

    final result = await repository.getRestaurants();

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error.message)),
      (restaurants) => emit(state.copyWith(isLoading: false, restaurants: restaurants, selectedCategory: null)),
    );
  }

  Future<void> _onChanged(RestaurantCategoryChanged event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, selectedCategory: event.categoryName));

    final result = await repository.getRestaurantsByCategory(event.categoryName);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error.message)),
      (restaurants) =>
          emit(state.copyWith(isLoading: false, restaurants: restaurants, selectedCategory: event.categoryName)),
    );
  }
}

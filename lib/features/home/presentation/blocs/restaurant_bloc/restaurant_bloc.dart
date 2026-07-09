import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final HomeRepository repository;

  RestaurantBloc(this.repository) : super(const RestaurantState()) {
    on<RestaurantFetched>(_onFetched);
    on<RestaurantCategoryChanged>(_onChanged);
  }

  Future<void> _onFetched(RestaurantFetched event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, selectedCategory: null));

    try {
      final restaurants = await repository.getRestaurants();

      emit(state.copyWith(isLoading: false, restaurants: restaurants, selectedCategory: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onChanged(RestaurantCategoryChanged event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, selectedCategory: event.categoryName));

    try {
      final restaurants = await repository.getRestaurantsByCategory(event.categoryName);

      emit(
        state.copyWith(
          isLoading: false,
          restaurants: restaurants,
          selectedCategory: event.categoryName,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}

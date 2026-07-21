import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/domain/services/restaurant/repository/restaurant_repository.dart';
import 'package:foodexpress_mobile/application/restaurant_detail/restaurant_detail_event.dart';
import 'package:foodexpress_mobile/application/restaurant_detail/restaurant_detail_state.dart';

class RestaurantDetailBloc extends Bloc<RestaurantDetailEvent, RestaurantDetailState> {
  final RestaurantRepository repository;

  RestaurantDetailBloc(this.repository) : super(const RestaurantDetailState()) {
    on<RestaurantDetailFetched>(_onFetched);
  }

  Future<void> _onFetched(RestaurantDetailFetched event, Emitter<RestaurantDetailState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await repository.getRestaurantById(event.id);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error.message)),
      (restaurant) => emit(state.copyWith(isLoading: false, restaurant: restaurant)),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_detail_bloc/restaurant_detail_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_detail_bloc/restaurant_detail_state.dart';

class RestaurantDetailBloc extends Bloc<RestaurantDetailEvent, RestaurantDetailState> {
  final HomeRepository repository;

  RestaurantDetailBloc(this.repository) : super(const RestaurantDetailState()) {
    on<RestaurantDetailFetched>(_onFetched);
  }

  Future<void> _onFetched(
    RestaurantDetailFetched event,
    Emitter<RestaurantDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final restaurant = await repository.getRestaurantById(event.id);
      emit(state.copyWith(isLoading: false, restaurant: restaurant));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}

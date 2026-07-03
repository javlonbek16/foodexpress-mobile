import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_state.dart';

class RestaurantMenuBloc extends Bloc<RestaurantMenuFetched, RestaurantMenuState> {
  final HomeRepository repository;

  RestaurantMenuBloc(this.repository) : super(const RestaurantMenuState()) {
    on<RestaurantMenuFetched>(_onFetched);
  }

  Future<void> _onFetched(RestaurantMenuFetched event, Emitter<RestaurantMenuState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final menus = await repository.getMenuItemsByRestaurant(event.id);
      emit(state.copyWith(isLoading: false, menus: menus));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/order/domain/repositories/order_repository.dart';
import 'package:foodexpress_mobile/features/order/presentation/blocs/order_bloc/order_event.dart';
import 'package:foodexpress_mobile/features/order/presentation/blocs/order_bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;
  OrderBloc(this.repository) : super(const OrderState()) {
    on<LoadOrders>(onLoad);
    on<CreateOrder>(onCreate);
  }
  Future<void> onLoad(LoadOrders event, Emitter<OrderState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final orders = await repository.getOrders();

      print("Orderlar soni: ${orders.length}");
      print("Order: $orders");
      emit(state.copyWith(isLoading: false, orders: orders));
    } catch (e, s) {
      print("XATOLIK: $e");
      print(s);
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> onCreate(CreateOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(isLoading: true, isOrderCreated: false, clearError: true));

    try {
      await repository.postOrder(
        cartItems: event.cartItems,
        restaurantName: event.restaurantName,
        currency: event.currency,
        deliveryAddress: event.deliveryAddress,
        customerFullName: event.customerFullName,
      );

      final orders = await repository.getOrders();

      emit(state.copyWith(isLoading: false, orders: orders, isOrderCreated: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isOrderCreated: false, error: e.toString()));
    }
  }
}

import 'package:foodexpress_mobile/features/order/data/models/order_model.dart';

class OrderState {
  final List<OrderModel> orders;
  final bool isLoading;
  final bool isOrderCreated;
  final String? error;

  const OrderState({
    this.orders = const [],
    this.isLoading = false,
    this.isOrderCreated = false,
    this.error,
  });

  OrderState copyWith({
    List<OrderModel>? orders,
    bool? isLoading,
    bool? isOrderCreated,
    String? error,
    bool clearError = false,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      isOrderCreated: isOrderCreated ?? this.isOrderCreated,
      error: clearError ? null : error ?? this.error,
    );
  }
}

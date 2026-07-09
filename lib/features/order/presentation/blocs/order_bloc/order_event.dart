import 'package:foodexpress_mobile/features/order/data/models/order_model.dart';

abstract class OrderEvent {}

class LoadOrders extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final OrderModel order;

  CreateOrder(this.order);
}

class RefreshOrders extends OrderEvent {}

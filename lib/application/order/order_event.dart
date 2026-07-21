import 'package:foodexpress_mobile/infrastructure/models/cart/cart_item_model.dart';

abstract class OrderEvent {}

class LoadOrders extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final List<CartItemModel> cartItems;
  final String restaurantName;
  final String currency;
  final String deliveryAddress;
  final String customerFullName;

  CreateOrder({
    required this.cartItems,
    required this.restaurantName,
    required this.currency,
    required this.deliveryAddress,
    required this.customerFullName,
  });
}

class RefreshOrders extends OrderEvent {}

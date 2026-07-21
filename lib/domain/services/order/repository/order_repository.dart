import 'package:foodexpress_mobile/infrastructure/models/cart/cart_item_model.dart';
import 'package:foodexpress_mobile/infrastructure/models/order/order_model.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> getOrders();

  Future<OrderModel> postOrder({
    required List<CartItemModel> cartItems,
    required String restaurantName,
    required String currency,
    required String deliveryAddress,
    required String customerFullName,
  });
}

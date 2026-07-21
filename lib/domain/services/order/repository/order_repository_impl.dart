import 'package:foodexpress_mobile/infrastructure/extensions/cart_item_mapper.dart';
import 'package:foodexpress_mobile/infrastructure/models/cart/cart_item_model.dart';
import 'package:foodexpress_mobile/domain/services/order/order_api_service.dart';
import 'package:foodexpress_mobile/infrastructure/models/order/order_model.dart';
import 'package:foodexpress_mobile/infrastructure/models/order/order_request_model.dart';
import 'package:foodexpress_mobile/domain/services/order/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApiService orderRemoteDatasource;

  OrderRepositoryImpl(this.orderRemoteDatasource);

  @override
  Future<List<OrderModel>> getOrders() async {
    return await orderRemoteDatasource.getOrders();
  }

  @override
  Future<OrderModel> postOrder({
    required List<CartItemModel> cartItems,
    required String restaurantName,
    required String currency,
    required String deliveryAddress,
    required String customerFullName,
  }) async {
    final request = OrderRequestModel(
      restaurantId: cartItems.first.restaurantId,
      restaurantName: restaurantName,
      currency: currency,
      deliveryAddress: deliveryAddress,
      customerFullName: customerFullName,
      items: cartItems.map((e) => e.toOrderItem()).toList(),
    );
    return await orderRemoteDatasource.postOrder(request);
  }
}

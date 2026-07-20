import 'package:foodexpress_mobile/core/extensions/cart_item_mapper.dart';
import 'package:foodexpress_mobile/features/cart/data/models/cart_item_model.dart';
import 'package:foodexpress_mobile/features/order/data/datasources/order_remote_datasource.dart';
import 'package:foodexpress_mobile/features/order/data/models/order_model.dart';
import 'package:foodexpress_mobile/features/order/data/models/order_request_model.dart';
import 'package:foodexpress_mobile/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource orderRemoteDatasource;

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

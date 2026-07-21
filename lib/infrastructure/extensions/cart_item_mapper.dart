import 'package:foodexpress_mobile/infrastructure/models/cart/cart_item_model.dart';
import 'package:foodexpress_mobile/infrastructure/models/order/order_request_model.dart';

extension CartItemMapper on CartItemModel {
  OrderItemRequestModel toOrderItem() {
    return OrderItemRequestModel(
      menuItemId: int.parse(menuItemId),
      name: name,
      quantity: quantity,
      price: price,
      imgUrl: image,
    );
  }
}

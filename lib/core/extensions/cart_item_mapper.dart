import 'package:foodexpress_mobile/features/cart/data/models/cart_item_model.dart';
import 'package:foodexpress_mobile/features/order/data/models/order_request_model.dart';

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

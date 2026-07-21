import 'package:foodexpress_mobile/infrastructure/models/cart/cart_item_model.dart';

abstract class CartEvent {}

class CartLoadRequested extends CartEvent {
  CartLoadRequested();
}

class CartItemAdded extends CartEvent {
  final CartItemModel item;

  CartItemAdded(this.item);
}

class CartItemRemoved extends CartEvent {
  final String menuItemId;

  CartItemRemoved(this.menuItemId);
}

class CartItemQuantityChanged extends CartEvent {
  final String menuItemId;
  final int quantity;

  CartItemQuantityChanged(this.menuItemId, this.quantity);
}

class CartCleared extends CartEvent {
  CartCleared();
}

class CartReplaceRequested extends CartEvent {
  final CartItemModel item;

  CartReplaceRequested(this.item);
}

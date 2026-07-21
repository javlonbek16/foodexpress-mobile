import 'package:foodexpress_mobile/infrastructure/models/cart/cart_item_model.dart';

abstract class CartLocalDatasource {
  Future<List<CartItemModel>> getCartItems();

  Future<void> addToCart(CartItemModel item);

  Future<void> removeFromCart(String menuItemId);

  Future<void> updateQuantity(String menuItemId, int quantity);

  Future<void> clearCart();

  Future<bool> isInCart(String menuItemId);

  Future<CartItemModel?> getCartItem(String menuItemId);

  Future<int> getCartCount();

  Future<double> getTotalPrice();
}

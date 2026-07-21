import 'package:foodexpress_mobile/domain/services/cart/cart_local_datasource_impl.dart';
import 'package:foodexpress_mobile/infrastructure/models/cart/cart_item_model.dart';
import 'package:foodexpress_mobile/domain/services/cart/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDatasourceImpl datasource;

  CartRepositoryImpl(this.datasource);

  @override
  Future<void> addToCart(CartItemModel item) => datasource.addToCart(item);

  @override
  Future<void> clearCart() => datasource.clearCart();

  @override
  Future<int> getCartCount() => datasource.getCartCount();

  @override
  Future<CartItemModel?> getCartItem(String menuItemId) => datasource.getCartItem(menuItemId);

  @override
  Future<List<CartItemModel>> getCartItems() => datasource.getCartItems();

  @override
  Future<double> getTotalPrice() => datasource.getTotalPrice();

  @override
  Future<bool> isInCart(String menuItemId) => datasource.isInCart(menuItemId);

  @override
  Future<void> removeFromCart(String menuItemId) => datasource.removeFromCart(menuItemId);

  @override
  Future<void> updateQuantity(String menuItemId, int quantity) => datasource.updateQuantity(menuItemId, quantity);
}

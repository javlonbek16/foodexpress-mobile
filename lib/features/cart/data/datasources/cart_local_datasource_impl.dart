import 'dart:convert';

import 'package:foodexpress_mobile/core/constants/cart_constants.dart';
import 'package:foodexpress_mobile/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:foodexpress_mobile/features/cart/data/models/cart_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartLocalDatasourceImpl implements CartLocalDatasource {
  final SharedPreferences prefs;

  CartLocalDatasourceImpl(this.prefs);

  Future<void> _saveCart(List<CartItemModel> items) async {
    final jsonList = items.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(CartConstants.cartKey, jsonList);
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    final cart = await getCartItems();

    final index = cart.indexWhere((element) => element.menuItemId == item.menuItemId);

    if (index != -1) {
      final oldItem = cart[index];

      cart[index] = oldItem.copyWith(quantity: oldItem.quantity + item.quantity);
    } else {
      cart.add(item);
    }

    await _saveCart(cart);
  }

  @override
  Future<void> clearCart() async {
    await prefs.remove(CartConstants.cartKey);
  }

  @override
  Future<int> getCartCount() async {
    final cart = await getCartItems();

    int total = 0;

    for (final item in cart) {
      total = total + item.quantity;
    }

    return total;
  }

  @override
  Future<CartItemModel?> getCartItem(String menuItemId) async {
    final cart = await getCartItems();

    try {
      return cart.firstWhere((element) => element.menuItemId == menuItemId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final list = prefs.getStringList(CartConstants.cartKey);
    if (list == null) {
      return [];
    }

    return list.map((e) => CartItemModel.fromJson(jsonDecode(e))).toList();
  }

  @override
  Future<double> getTotalPrice() async {
    final cart = await getCartItems();

    double total = 0;

    for (final item in cart) {
      total = total + item.price * item.quantity;
    }

    return total;
  }

  @override
  Future<bool> isInCart(String menuItemId) async {
    final cart = await getCartItems();

    return cart.any((element) => element.menuItemId == menuItemId);
  }

  @override
  Future<void> removeFromCart(String menuItemId) async {
    final cart = await getCartItems();

    cart.removeWhere((element) => element.menuItemId == menuItemId);

    await _saveCart(cart);
  }

  @override
  Future<void> updateQuantity(String menuItemId, int quantity) async {
    final cart = await getCartItems();

    final index = cart.indexWhere((e) => e.menuItemId == menuItemId);

    if (index == -1) return;

    if (quantity <= 0) {
      cart.removeAt(index);
    } else {
      cart[index] = cart[index].copyWith(quantity: quantity);
    }

    await _saveCart(cart);
  }
}

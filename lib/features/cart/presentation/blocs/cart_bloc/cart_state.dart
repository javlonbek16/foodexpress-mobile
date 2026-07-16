import 'package:foodexpress_mobile/features/cart/data/models/cart_item_model.dart';

class CartState {
  final List<CartItemModel> cartItems;
  final bool isLoading;
  final String? error;

  const CartState({this.cartItems = const [], this.isLoading = false, this.error});

  CartState copyWith({List<CartItemModel>? cartItems, bool? isLoading, String? error}) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

extension CartStateExtension on CartState {
  int quantityOf(int id) {
    try {
      return cartItems.firstWhere((e) => e.menuItemId == id).quantity;
    } catch (_) {
      return 0;
    }
  }
}

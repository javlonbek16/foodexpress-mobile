import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/cart/domain/repositories/cart_repository.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_event.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(const CartState()) {
    on<CartLoadRequested>(_onFetched);
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartItemQuantityChanged>(_onItemQuantityChanged);
    on<CartCleared>(_onCleared);
    on<CartReplaceRequested>(_onCartReplace);
  }

  Future<void> _onFetched(CartLoadRequested event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final cartItems = await repository.getCartItems();

      emit(state.copyWith(isLoading: false, cartItems: cartItems));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await repository.addToCart(event.item);

      final cartItems = await repository.getCartItems();
      debugPrint("Cart items count: ${cartItems.length}");

      emit(state.copyWith(isLoading: false, cartItems: cartItems));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await repository.removeFromCart(event.menuItemId);

      final cartItems = await repository.getCartItems();

      emit(state.copyWith(isLoading: false, cartItems: cartItems));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onItemQuantityChanged(
    CartItemQuantityChanged event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await repository.updateQuantity(event.menuItemId, event.quantity);

      final cartItems = await repository.getCartItems();

      emit(state.copyWith(isLoading: false, cartItems: cartItems));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onCartReplace(CartReplaceRequested event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await repository.clearCart();
      await repository.addToCart(event.item);
      final cartItems = await repository.getCartItems();

      emit(state.copyWith(isLoading: false, cartItems: cartItems));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onCleared(CartCleared event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await repository.clearCart();

      emit(state.copyWith(isLoading: false, cartItems: const []));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}

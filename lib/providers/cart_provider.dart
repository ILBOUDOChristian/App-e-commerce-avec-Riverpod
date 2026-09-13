import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartState {
  final List<CartItem> items;
  final double shippingFee;

  const CartState({
    this.items = const [],
    this.shippingFee = 4.99,
  });

  int get totalItemCount =>
      items.fold(0, (total, item) => total + item.quantity);

  double get subtotal =>
      items.fold(0.0, (total, item) => total + item.totalPrice);

  double get deliveryCost => items.isEmpty ? 0.0 : (subtotal > 100 ? 0.0 : shippingFee);

  double get grandTotal => items.isEmpty ? 0.0 : subtotal + deliveryCost;

  bool get isEmpty => items.isEmpty;

  CartState copyWith({
    List<CartItem>? items,
    double? shippingFee,
  }) {
    return CartState(
      items: items ?? this.items,
      shippingFee: shippingFee ?? this.shippingFee,
    );
  }
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());

  void addToCart(Product product, {int quantity = 1}) {
    final existingIndex =
        state.items.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      final updatedList = List<CartItem>.from(state.items);
      final currentItem = updatedList[existingIndex];
      updatedList[existingIndex] = currentItem.copyWith(
        quantity: currentItem.quantity + quantity,
      );
      state = state.copyWith(items: updatedList);
    } else {
      state = state.copyWith(
        items: [...state.items, CartItem(product: product, quantity: quantity)],
      );
    }
  }

  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final updatedList = state.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedList);
  }

  void removeFromCart(String productId) {
    final updatedList =
        state.items.where((item) => item.product.id != productId).toList();
    state = state.copyWith(items: updatedList);
  }

  void clearCart() {
    state = state.copyWith(items: const []);
  }
}

/// [Provider 4] StateNotifierProvider pour la gestion complète du panier d'achat
final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

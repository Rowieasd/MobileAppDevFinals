import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => _cartItems;

  int get itemCount =>
      _cartItems.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _cartItems.values.fold(
    0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id]!.quantity++;
    } else {
      _cartItems[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  void incrementQuantity(String id) {
    _cartItems[id]?.quantity++;
    notifyListeners();
  }

  void decrementQuantity(String id) {
    if (!_cartItems.containsKey(id)) return;

    if (_cartItems[id]!.quantity > 1) {
      _cartItems[id]!.quantity--;
    } else {
      _cartItems.remove(id);
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

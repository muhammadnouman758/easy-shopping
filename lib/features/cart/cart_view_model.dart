import 'package:flutter/material.dart';
import '../products/product_model.dart';
import 'cart_item_model.dart';

class CartViewModel with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  double _deliveryFee = 5.99;
  double _taxRate = 0.08; // 8% tax

  List<CartItem> get cartItems => _cartItems;
  double get deliveryFee => _deliveryFee;
  double get taxRate => _taxRate;
  int get cartCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get tax {
    return subtotal * _taxRate;
  }

  double get total {
    return subtotal + tax + _deliveryFee;
  }

  void addToCart(Product product, {String color = 'Default', String size = 'M'}) {
    final existingIndex = _cartItems.indexWhere(
          (cartItem) =>
      cartItem.productId == product.id &&
          cartItem.selectedColor == color &&
          cartItem.selectedSize == size,
    );

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += 1;
    } else {
      _cartItems.add(
        CartItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          productId: product.id,
          name: product.name,
          imageUrl: product.imageUrls.first,
          price: product.price,
          selectedColor: color,
          selectedSize: size,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int newQuantity) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      _cartItems[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
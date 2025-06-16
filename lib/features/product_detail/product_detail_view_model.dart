import 'package:flutter/material.dart';

import '../products/product_model.dart';

class ProductDetailViewModel with ChangeNotifier {
  Product product;
  int _currentImageIndex = 0;
  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  ProductDetailViewModel({required this.product}) {
    _selectedColor = product.availableColors.first;
    _selectedSize = product.availableSizes.first;
  }

  int get currentImageIndex => _currentImageIndex;
  String? get selectedColor => _selectedColor;
  String? get selectedSize => _selectedSize;
  int get quantity => _quantity;

  void updateImageIndex(int index) {
    _currentImageIndex = index;
    notifyListeners();
  }

  void selectColor(String color) {
    _selectedColor = color;
    notifyListeners();
  }

  void selectSize(String size) {
    _selectedSize = size;
    notifyListeners();
  }

  void increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void toggleFavorite() {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }
}
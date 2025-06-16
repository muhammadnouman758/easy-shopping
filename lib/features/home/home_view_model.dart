import 'package:flutter/material.dart';

import '../products/category_card.dart';
import '../products/product_model.dart';

class HomeViewModel with ChangeNotifier {
  int _currentBanner = 0;
  int _cartCount = 3; // Demo value
  final List<String> _bannerImages = [
    'assets/pos-1.jpg',
    'assets/pos-2.jpg',
    'assets/pos-3.jpg',
  ];

  final List<Category> _categories = [
    Category(
      id: '1',
      name: 'Electronics',
      icon: 'assets/electronic.jpg',
      imageUrl: 'assets/electronic.jpg',
    ),
    Category(
      id: '2',
      name: 'Fashion',
      icon: 'assets/fashion.jpg',
      imageUrl: 'assets/fashion.jpg',
    ),
    Category(
      id: '3',
      name: 'Home',
      icon: 'assets/home-app.jpg',
      imageUrl: 'assets/home-app.jpg',
    ),
    Category(
      id: '4',
      name: 'Beauty',
      icon: 'assets/cosmetic.jpg',
      imageUrl: 'assets/cosmetic.jpg',
    ),
  ];

  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Wireless Headphones',
      description: 'Noise cancelling wireless headphones with 30hr battery',
      price: 199.99,
      oldPrice: 249.99,
      imageUrls: ['assets/headphone.jpg'], // Changed to imageUrls list
      rating: 4.5,
      categories: ['1'],
    ),
    Product(
      id: '2',
      name: 'Smart Watch',
      description: 'Fitness tracker with heart rate monitor',
      price: 159.99,
      imageUrls: ['assets/mobile-watch.jpg'], // Changed to imageUrls list
      rating: 4.2,
      categories: ['1'],
    ),
    Product(
      id: '3',
      name: 'Running Shoes',
      description: 'Lightweight running shoes with cushioning',
      price: 89.99,
      imageUrls: ['assets/shoe-2.jpg'], // Changed to imageUrls list
      rating: 4.7,
      categories: ['2'],
    ),
    Product(
      id: '4',
      name: 'Blender',
      description: 'High power blender for smoothies and food prep',
      price: 79.99,
      oldPrice: 99.99,
      imageUrls: ['assets/blender.jpg'], // Changed to imageUrls list
      rating: 4.3,
      categories: ['3'],
    ),
  ];

  int get currentBanner => _currentBanner;
  int get cartCount => _cartCount;
  List<String> get bannerImages => _bannerImages;
  List<Category> get categories => _categories;
  List<Product> get products => _products;

  void updateBannerIndex(int index) {
    _currentBanner = index;
    notifyListeners();
  }

  void toggleFavorite(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _products[index].isFavorite = !_products[index].isFavorite;
      notifyListeners();
    }
  }

  void addToCart(String productId) {
    // In a real app, you would add to cart logic here
    _cartCount++;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

import '../products/product_model.dart';

class SearchViewModel with ChangeNotifier {
  final List<String> _recentSearches = [];
  List<Product> _searchResults = [];
  bool _isSearching = false;
  String _searchQuery = '';

  List<String> get recentSearches => _recentSearches;
  List<Product> get searchResults => _searchResults;
  bool get isSearching => _isSearching;
  String get searchQuery => _searchQuery;

  void searchProducts(String query, List<Product> allProducts) {
    _searchQuery = query;
    _isSearching = true;
    notifyListeners();

    // Simulate API call delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = allProducts.where((product) {
          return product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()) ||
              product.brand.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }

      _isSearching = false;
      notifyListeners();

      // Add to recent searches if not empty and not already present
      if (query.isNotEmpty && !_recentSearches.contains(query)) {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
        notifyListeners();
      }
    });
  }

  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    _isSearching = false;
    notifyListeners();
  }

  void removeRecentSearch(String searchTerm) {
    _recentSearches.remove(searchTerm);
    notifyListeners();
  }

  void clearRecentSearches() {
    _recentSearches.clear();
    notifyListeners();
  }
}
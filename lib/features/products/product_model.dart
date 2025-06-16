class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? oldPrice;
  final List<String> imageUrls; // Changed from single imageUrl to list
  final double rating;
  final int reviewCount;
  late final bool isFavorite;
  final List<String> categories;
  final List<String> availableColors;
  final List<String> availableSizes;
  final String brand;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.imageUrls,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isFavorite = false,
    required this.categories,
    this.availableColors = const ['Black', 'White', 'Blue', 'Red'],
    this.availableSizes = const ['S', 'M', 'L', 'XL'],
    this.brand = 'Generic',
  });
}
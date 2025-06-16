class CartItem {
  final String id;
  final String productId;
  final String name;
  final String imageUrl;
  final double price;
  final String selectedColor;
  final String selectedSize;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.selectedColor,
    required this.selectedSize,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  // Convert CartItem to a Map for Firestore/database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'quantity': quantity,
    };
  }

  // Factory method to create CartItem from a Map (e.g., from Firestore)
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      productId: map['productId'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      price: map['price'].toDouble(),
      selectedColor: map['selectedColor'],
      selectedSize: map['selectedSize'],
      quantity: map['quantity'],
    );
  }
}
class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? imageUrl;
  final DateTime? joinDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.imageUrl,
    this.joinDate,
  });
}
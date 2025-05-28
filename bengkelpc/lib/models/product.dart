class Product {
  final String name;
  final int price;
  int quantity;
  bool isFavorite;
  String? selectedVariant;

  Product({
    required this.name,
    required this.price,
    this.quantity = 0,
    this.isFavorite = false,
    this.selectedVariant,
  });
}
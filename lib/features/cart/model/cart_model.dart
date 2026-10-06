class CartModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String selectedColor;
  final String selectedSize;
  final int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.selectedColor,
    required this.selectedSize, required this.imageUrl,
  });

  CartModel copyWith({int? quantity,String? selectedColor,String? selectedSize}) {
    return CartModel(
      id: id,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity, selectedColor: selectedColor??this.selectedColor, selectedSize:selectedSize??this.selectedSize, imageUrl: imageUrl,
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl':imageUrl,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'quantity': quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'] as String,
      selectedColor: map['selectedColor'] as String,
      selectedSize: map['selectedSize'] as String,
      quantity: map['quantity'] as int,
    );
  }
}

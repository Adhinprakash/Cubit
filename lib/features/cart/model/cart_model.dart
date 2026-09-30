class CartModel {
  final String id;
  final String name;
  final double price;
int quantity;

  CartModel({required this.id, required this.name, required this.price, this.quantity=1});

  CartModel copyWith({int? quantity}){
    return CartModel(id: id, name: name, price: price,quantity: quantity??this.quantity);
  }
}
class CartItemModel {
  final int id;
  final String title;
  final String image;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }
}

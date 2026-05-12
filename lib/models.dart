class ProductModel {
  final int? id;
  final String name;
  final String price;
  final String description;

  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'].toString(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": int.parse(price),
      "description": description,
    };
  }
}

class ProductModel {
  final int id;
  final String name;
  final String price;
  final String unit;
  final String category;
  final String image;
  int? quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.unit,
    required this.category,
    required this.image,
    this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final String price = json["price"];
    
    return ProductModel(
      id: json["id"],
      name: json["name"],
      price: price.replaceAll('.', ','),
      unit: json["unit"],
      category: json["category"],
      image: json["image"],
      quantity: json["quantity"] ?? 0,
    );
  }
}

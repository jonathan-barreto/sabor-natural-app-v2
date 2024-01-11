class ProductCartModel {
  final int id;
  int quantity;

  ProductCartModel({
    required this.id,
    required this.quantity,
  });

  factory ProductCartModel.fromJson(Map<String, dynamic> json) {
    return ProductCartModel(
      id: json["id"],
      quantity: json["quantity"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    return data;
  }
}

class ProductResponse {
  final String? nextPageUrl;
  final List products;

  ProductResponse({
    required this.nextPageUrl,
    required this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      nextPageUrl: json["links"]["next"],
      products: json["data"],
    );
  }
}

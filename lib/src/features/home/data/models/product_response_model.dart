class ProductResponse {
  final String? nextPageUrl;
  final List products;

  ProductResponse({
    required this.nextPageUrl,
    required this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      nextPageUrl: json["next_page_url"],
      products: json["data"],
    );
  }
}
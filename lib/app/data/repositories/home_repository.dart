import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:natural_app/app/core/shared/constants/constants.dart';
import 'package:natural_app/app/data/model/product_cart_model.dart';
import 'package:natural_app/app/data/model/product_model.dart';
import 'package:natural_app/app/data/model/product_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRespository {
  final Dio dio;
  final SharedPreferences prefs;
  String? nextUrl;

  HomeRespository({
    required this.dio,
    required this.prefs,
  });

  List<ProductModel> getList({required Map<String, dynamic> json}) {
    final List<ProductModel> productsList = [];

    final ProductResponse productResponse = ProductResponse.fromJson(
      json,
    );

    nextUrl = productResponse.nextPageUrl;

    productsList.addAll(
      productResponse.products.map(
        (e) => ProductModel.fromJson(e),
      ),
    );

    return productsList;
  }

  Future<List<ProductModel>> fetch({required String url}) async {
    final response = await dio.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    final List<ProductModel> products = getList(
      json: response.data,
    );

    return products;
  }

  Future<List<ProductModel>> fetchProducts() async {
    const String url = ConstantsUrls.fetchProducts;

    final List<ProductModel> products = await fetch(
      url: url,
    );

    return products;
  }

  Future<List<ProductModel>> fetchMoreProducts() async {
    if (nextUrl == null) return [];

    final List<ProductModel> products = await fetch(
      url: nextUrl!,
    );

    return products;
  }

  Future<List<ProductModel>> fetchSearchProducts({
    required String search,
  }) async {
    final String searchUrl = '${ConstantsUrls.searchProducts}$search';

    final List<ProductModel> products = await fetch(
      url: searchUrl,
    );

    return products;
  }

  Future<List<String>?> returnProductsSaved() async {
    final List<String>? products = prefs.getStringList("products");
    return products ?? [];
  }

  Future<int> returnTotalItemsInCart() async {
    final List<String>? products = await returnProductsSaved();
    return products?.length ?? 0;
  }

  Future<int> addItemToCart(int index, int id, int quantity) async {
    final List<String>? productsSaved = await returnProductsSaved();

    final productCartModel = ProductCartModel(
      id: id,
      quantity: quantity,
    );

    if (productsSaved == null) {
      await prefs.setStringList(
        "products",
        [jsonEncode(productCartModel.toJson())],
      );
    } else {
      bool foundProduct = false;

      for (int i = 0; i < productsSaved.length; i++) {
        final productJson = ProductCartModel.fromJson(
          jsonDecode(productsSaved[i]),
        );

        if (productCartModel.id == productJson.id) {
          foundProduct = true;

          productCartModel.quantity += productJson.quantity;
          productsSaved[i] = jsonEncode(productCartModel);
        }
      }

      if (!foundProduct) {
        productsSaved.add(jsonEncode(productCartModel));
      }
    }

    await prefs.setStringList("products", productsSaved ?? []);

    return productsSaved?.length ?? 0;
  }
}

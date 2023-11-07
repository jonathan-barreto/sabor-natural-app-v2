import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:natural_app/src/features/home/data/models/product_cart_model.dart';
import 'package:natural_app/src/features/home/data/models/product_model.dart';
import 'package:natural_app/src/features/home/data/models/product_response_model.dart';
import 'package:natural_app/src/states/raw_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRespository extends ValueNotifier<RawState> {
  final Dio dio;
  final SharedPreferences prefs;

  String? url = 'http://127.0.0.1:8000/api/products';

  HomeRespository({required this.dio, required this.prefs})
      : super(const IdleState());

  Future<List<ProductModel>> fetchProducts({required bool isFirstFetch}) async {
    if (url == null) return [];

    final response = await dio.get(url!);
    final List<ProductModel> products = [];
    final productResponse = ProductResponse.fromJson(response.data);

    url = productResponse.nextPageUrl;

    products.addAll(
      productResponse.products.map(
        (e) => ProductModel.fromJson(e),
      ),
    );

    return products;
  }

  Future<List<String>?> returnProductsSaved() async {
    final List<String>? products = prefs.getStringList("products");

    return products ?? [];
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

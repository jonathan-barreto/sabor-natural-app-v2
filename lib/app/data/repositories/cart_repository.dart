import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:natural_app/app/core/shared/constants/constants.dart';
import 'package:natural_app/app/data/model/product_cart_model.dart';
import 'package:natural_app/app/data/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final Dio dio;
  final SharedPreferences prefs;

  CartRepository({
    required this.dio,
    required this.prefs,
  });

  List<ProductCartModel> getTheModelList({required List<String>? products}) {
    final List<ProductCartModel> productsCartModel = [];

    if (products == null) return [];

    productsCartModel.addAll(
      products.map(
        (e) => ProductCartModel.fromJson(
          jsonDecode(e),
        ),
      ),
    );

    return productsCartModel;
  }

  List<int> getTheIdsProductList({required List<ProductCartModel> products}) {
    final List<int> idsProducts = [];

    idsProducts.addAll(products.map((product) => product.id));

    return idsProducts;
  }

  Future<List<ProductModel>> getTheListProductModel({
    required List<int> idsProducts,
    required List<ProductCartModel> productsCartModel,
  }) async {
    final Map<String, List> data = {
      "idsProducts": idsProducts,
    };

    final response = await dio.post(
      ConstantsUrls.fetchProducts,
      data: jsonEncode(data),
    );

    final productsResponse = response.data["products"] as List;

    final List<ProductModel> productsModel = [];

    for (int index = 0; index < productsResponse.length; index++) {
      productsResponse[index]["quantity"] = productsCartModel[index].quantity;
      productsModel.add(ProductModel.fromJson(productsResponse[index]));
    }

    return productsModel;
  }

  Future<List<ProductModel>> fetchCartProducts() async {
    final List<String>? products = prefs.getStringList("products");

    final List<ProductCartModel> productsCartModel = getTheModelList(
      products: products,
    );

    final List<int> idsProducts = getTheIdsProductList(
      products: productsCartModel,
    );

    if (idsProducts.isEmpty) return [];
   
    final List<ProductModel> productsModel = await getTheListProductModel(
      idsProducts: idsProducts,
      productsCartModel: productsCartModel,
    );

    return productsModel;
  }

  Future<List<String>> saveInShared({required int index}) async {
    final List<String>? products = prefs.getStringList("products");

    if (products == null) return [];

    final productCart = ProductCartModel.fromJson(
      jsonDecode(
        products[index],
      ),
    );

    productCart.quantity = productCart.quantity + 1;

    products[index] = jsonEncode(productCart);

    await prefs.setStringList("products", products);

    return products;
  }

  List<ProductModel> saveInList(int index, List<ProductModel> products) {
    final productModel = products[index];

    productModel.quantity = productModel.quantity! + 1;

    products[index] = productModel;

    return products;
  }

  Future<List<ProductModel>> incrementQuantity(
    int index,
    List<ProductModel> products,
  ) async {
    await saveInShared(index: index);

    final newProductList = saveInList(index, products);

    return newProductList;
  }

  void clearProducts() async {
    await prefs.remove("products");
  }
}

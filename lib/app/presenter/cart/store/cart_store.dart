import 'package:flutter/material.dart';
import 'package:natural_app/app/data/repositories/cart_repository.dart';
import 'package:natural_app/app/presenter/cart/state/cart_state.dart';
import 'package:natural_app/app/data/model/product_model.dart';

import 'package:natural_app/app/core/state/raw_state.dart';

class CartStore extends ValueNotifier<RawState> {
  final CartRepository repository;

  CartStore({required this.repository}) : super(const IdleState());

  Future<void> fetchProducts() async {
    value = const LoadingState();

    final List<ProductModel> products = await repository.fetchCartProducts();

    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );

    value = SuccessState<CartState>(
      output: CartState.fetchProducts(
        listProducts: products,
      ),
    );
  }

  Future<void> incrementQuantity({
    required int index,
    required List<ProductModel> products,
  }) async {
    final List<ProductModel> productsList = await repository.incrementQuantity(
      index,
      products,
    );

    value = SuccessState(
      output: CartState.fetchProducts(
        listProducts: productsList,
      ),
    );
  }

  Future<void> clearProducts() async {
    repository.clearProducts();
    await fetchProducts();
  }
}

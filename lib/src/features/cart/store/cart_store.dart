import 'package:flutter/material.dart';
import 'package:natural_app/src/features/cart/data/repository/cart_repository.dart';
import 'package:natural_app/src/features/cart/state/cart_state.dart';
import 'package:natural_app/src/features/home/data/models/product_model.dart';
import 'package:natural_app/src/states/raw_state.dart';

class CartStore extends ValueNotifier<RawState> {
  final CartRepository cartRepository;

  CartStore({required this.cartRepository}) : super(const IdleState());

  Future<void> fetchProducts() async {
    value = const LoadingState();

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    List<ProductModel> products = await cartRepository.fetchProducts();

    if (value is SuccessState<CartState>) {
      final state = value as SuccessState<CartState>;
    } else {
      value = SuccessState<CartState>(
        output: CartState.fetchProducts(
          listProducts: products,
        ),
      );
    }
  }

  void clearProducts() {
    cartRepository.clearProducts();
  }
}

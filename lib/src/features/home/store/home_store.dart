import 'package:flutter/material.dart';
import 'package:natural_app/src/features/home/data/repository/home_repository.dart';
import 'package:natural_app/src/features/home/state/home_state.dart';
import 'package:natural_app/src/features/home/data/models/product_model.dart';
import 'package:natural_app/src/states/raw_state.dart';

class HomeStore extends ValueNotifier<RawState> {
  final HomeRespository homeRespository;

  HomeStore({required this.homeRespository}) : super(const IdleState());

  Future<void> fetchProducts({required bool isFirstFetch}) async {
    if (isFirstFetch) {
      value = const LoadingState();
    }

    if (value is SuccessState<HomeState>) {
      final state = value as SuccessState<HomeState>;

      value = SuccessState<HomeState>(
        output: state.output.copyWith(
          showLoading: true,
        ),
      );
    }

    List<ProductModel> products = await homeRespository.fetchProducts(
      isFirstFetch: isFirstFetch,
    );

    final int totalProducts = products.length;

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (value is SuccessState<HomeState>) {
      final state = value as SuccessState<HomeState>;

      List<ProductModel> allProducts = [
        ...state.output.products,
        ...products,
      ];

      value = SuccessState(
        output: HomeState.fetchProducts(
          listProducts: allProducts,
          totalItemsInCart: totalProducts,
          showLoading: false,
        ),
      );
    } else {
      value = SuccessState(
        output: HomeState.fetchProducts(
          listProducts: products,
          totalItemsInCart: totalProducts,
          showLoading: false,
        ),
      );
    }
  }

  void incrementQuantityProduct({required int index}) {
    final state = value as SuccessState<HomeState>;

    if (value is SuccessState<HomeState>) {
      final quantity = state.output.products[index].quantity ?? 0;

      state.output.products[index].quantity = quantity + 1;

      value = SuccessState(
        output: state.output.copyWith(),
      );
    }
  }

  void decrementQuantityProduct({required int index}) {
    final state = value as SuccessState<HomeState>;

    if (value is SuccessState<HomeState>) {
      final quantity = state.output.products[index].quantity ?? 0;

      if (quantity != 0) {
        state.output.products[index].quantity = quantity - 1;

        value = SuccessState(
          output: state.output.copyWith(),
        );
      }
    }
  }

  void addItemToCart({
    required int index,
    required int id,
    required int quantity,
  }) async {
    final state = value as SuccessState<HomeState>;

    final int total = await homeRespository.addItemToCart(index, id, quantity);

    if (value is SuccessState<HomeState>) {
      state.output.products[index].quantity = 0;

      value = SuccessState(
        output: state.output.copyWith(totalItemsInCart: total),
      );
    }
  }
}

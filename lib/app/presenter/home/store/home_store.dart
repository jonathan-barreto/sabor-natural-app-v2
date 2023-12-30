import 'package:flutter/material.dart';
import 'package:natural_app/app/data/model/product_model.dart';
import 'package:natural_app/app/data/repositories/home_repository.dart';
import 'package:natural_app/app/presenter/home/state/home_state.dart';
import 'package:natural_app/app/core/state/raw_state.dart';

class HomeStore extends ValueNotifier<RawState> {
  final HomeRespository respository;

  HomeStore({required this.respository}) : super(const IdleState());

  Future<void> fetchProducts() async {
    value = const LoadingState();

    final List<ProductModel> products = await respository.fetchProducts();

    final int totalProducts = await respository.returnTotalItemsInCart();

    value = SuccessState(
      output: HomeState.fetchProducts(
        listProducts: products,
        moreProductLoading: false,
        productLoading: false,
      ),
    );
  }

  Future<void> fetchMoreProducts() async {
    if (value is SuccessState<HomeState>) {
      final state = value as SuccessState<HomeState>;

      value = SuccessState(
        output: state.output.copyWith(
          moreProductLoading: true,
        ),
      );

      final List<ProductModel> products = await respository.fetchMoreProducts();

      List<ProductModel> allProducts = [
        ...state.output.products,
        ...products,
      ];

      value = SuccessState(
        output: state.output.copyWith(
          products: allProducts,
          moreProductLoading: false,
        ),
      );
    }
  }

  Future<void> fetchSearchProducts({required String search}) async {
    if (value is SuccessState<HomeState>) {
      final state = value as SuccessState<HomeState>;

      value = SuccessState(
        output: state.output.copyWith(
          productLoading: true,
        ),
      );

      final List<ProductModel> products = await respository.fetchSearchProducts(
        search: search,
      );

      value = SuccessState(
        output: state.output.copyWith(
          products: products,
          productLoading: false,
        ),
      );
    }
  }

  Future<void> clearSearch() async {
    if (value is SuccessState<HomeState>) {
      final state = value as SuccessState<HomeState>;

      value = SuccessState(
        output: state.output.copyWith(
          productLoading: true,
        ),
      );

      final List<ProductModel> products = await respository.fetchProducts();

      value = SuccessState(
        output: state.output.copyWith(
          products: products,
          productLoading: false,
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

  int decrementQuantityProduct({required int index}) {
    final state = value as SuccessState<HomeState>;

    final int quantity = state.output.products[index].quantity ?? 0;

    if (value is SuccessState<HomeState>) {
      if (quantity != 0) {
        state.output.products[index].quantity = quantity - 1;

        value = SuccessState(
          output: state.output.copyWith(),
        );
      }
    }

    return quantity;
  }

  Future<int> addItemToCart(int index, int id, int quantity) async {
    final state = value as SuccessState<HomeState>;

    final int total = await respository.addItemToCart(
      index,
      id,
      quantity,
    );

    if (value is SuccessState<HomeState>) {
      state.output.products[index].quantity = 0;

      value = SuccessState(
        output: state.output.copyWith(
          totalItemsInCart: total,
        ),
      );
    }

    return total;
  }
}

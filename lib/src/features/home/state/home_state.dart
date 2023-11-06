import 'package:natural_app/src/features/home/data/models/product_model.dart';

class HomeState {
  final List<ProductModel> products;
  final bool showLoading;
  int? totalItemsInCart;

  HomeState({
    required this.products,
    required this.showLoading,
    this.totalItemsInCart,
  });

  factory HomeState.initial() {
    return HomeState(
      products: [],
      showLoading: true,
      totalItemsInCart: 0,
    );
  }

  factory HomeState.fetchProducts({
    required List<ProductModel> listProducts,
    required bool showLoading,
    required int totalItemsInCart,
  }) {
    return HomeState(
      products: listProducts,
      showLoading: showLoading,
      totalItemsInCart: totalItemsInCart,
    );
  }

  HomeState copyWith({
    int? totalItemsInCart,
    List<ProductModel>? products,
    bool? showLoading,
  }) {
    return HomeState(
      products: products ?? this.products,
      showLoading: showLoading ?? this.showLoading,
      totalItemsInCart: totalItemsInCart ?? this.totalItemsInCart,
    );
  }
}

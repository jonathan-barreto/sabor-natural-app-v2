import 'package:natural_app/src/features/home/data/models/product_model.dart';

class HomeState {
  final List<ProductModel> products;
  final bool showLoading;
  final bool productLoading;
  int? totalItemsInCart;

  HomeState({
    required this.products,
    required this.showLoading,
    required this.productLoading,
    this.totalItemsInCart,
  });

  factory HomeState.initial() {
    return HomeState(
      products: [],
      showLoading: true,
      productLoading: false,
      totalItemsInCart: 0,
    );
  }

  factory HomeState.fetchProducts({
    required List<ProductModel> listProducts,
    required bool showLoading,
    required bool productLoading,
    required int totalItemsInCart,
  }) {
    return HomeState(
      products: listProducts,
      showLoading: showLoading,
      productLoading: productLoading,
      totalItemsInCart: totalItemsInCart,
    );
  }

  HomeState copyWith({
    int? totalItemsInCart,
    List<ProductModel>? products,
    bool? showLoading,
    bool? productLoading,
  }) {
    return HomeState(
      products: products ?? this.products,
      showLoading: showLoading ?? this.showLoading,
      totalItemsInCart: totalItemsInCart ?? this.totalItemsInCart,
      productLoading: productLoading ?? this.productLoading,
    );
  }
}

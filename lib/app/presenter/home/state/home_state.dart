import 'package:natural_app/app/data/model/product_model.dart';

class HomeState {
  final List<ProductModel> products;
  final bool moreProductLoading;
  final bool searchProductLoading;

  HomeState({
    required this.products,
    required this.moreProductLoading,
    required this.searchProductLoading,
  });

  factory HomeState.initial() {
    return HomeState(
      products: [],
      moreProductLoading: true,
      searchProductLoading: false,
    );
  }

  factory HomeState.fetchProducts({
    required List<ProductModel> listProducts,
    required bool moreProductLoading,
    required bool productLoading,
  }) {
    return HomeState(
      products: listProducts,
      moreProductLoading: moreProductLoading,
      searchProductLoading: productLoading,
    );
  }

  HomeState copyWith({
    List<ProductModel>? products,
    int? totalItemsInCart,
    bool? moreProductLoading,
    bool? productLoading,
  }) {
    return HomeState(
      products: products ?? this.products,
      moreProductLoading: moreProductLoading ?? this.moreProductLoading,
      searchProductLoading: productLoading ?? searchProductLoading,
    );
  }
}

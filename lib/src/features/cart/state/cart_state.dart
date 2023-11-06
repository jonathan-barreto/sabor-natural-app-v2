import 'package:natural_app/src/features/home/data/models/product_model.dart';

class CartState {
  final List<ProductModel> products;

  CartState({required this.products});

  factory CartState.initial() {
    return CartState(
      products: [],
    );
  }

  factory CartState.fetchProducts({required List<ProductModel> listProducts}) {
    return CartState(
      products: listProducts,
    );
  }

  CartState copyWith(List<ProductModel>? products) {
    return CartState(
      products: products ?? this.products,
    );
  }
}

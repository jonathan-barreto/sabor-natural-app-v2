import 'package:flutter/material.dart';
import 'package:natural_app/app/data/model/product_model.dart';
import 'package:natural_app/app/presenter/cart/widgets/row_products_cart.dart';

class ListViewCart extends StatelessWidget {
  final List<ProductModel> products;
  final void Function(int, List<ProductModel>) increment;

  const ListViewCart({
    super.key,
    required this.products,
    required this.increment,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final ProductModel product = products[index];
        return RowProductsCart(
          product: product,
          increment: () => increment(
            index,
            products,
          ),
        );
      },
    );
  }
}

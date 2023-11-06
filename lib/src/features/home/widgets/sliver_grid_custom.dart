import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:natural_app/src/features/home/data/models/product_model.dart';
import 'package:natural_app/src/features/home/widgets/product_list_item.dart';
import 'package:natural_app/src/features/home/widgets/row_button_store.dart';
import 'package:natural_app/src/helpers/colors/app_colors.dart';
import 'package:natural_app/src/helpers/constants/constants.dart';

class SliverGridCustom extends StatelessWidget {
  final List<ProductModel> products;
  final Function(int) incrementFunction;
  final Function(int) decrementFunction;
  final Function(int, int, int) addItemToCart;

  const SliverGridCustom({
    super.key,
    required this.products,
    required this.incrementFunction,
    required this.decrementFunction,
    required this.addItemToCart,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: (200 / 300),
      ),
      itemBuilder: (context, index) {
        final ProductModel product = products[index];
        return Card(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: CachedNetworkImage(
                    width: 100,
                    imageUrl: ConstantsUrls.fetchImage + product.image,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProductListItem(
                      name: product.name,
                      unit: product.unit,
                      price: product.price,
                    ),
                    const Divider(),
                    RowButtonStore(
                      index: index,
                      product: product,
                      incrementFunction: incrementFunction,
                      decrementFunction: decrementFunction,
                      addItemToCart: addItemToCart,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

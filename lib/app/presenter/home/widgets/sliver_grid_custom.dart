import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:natural_app/app/data/model/product_model.dart';
import 'package:natural_app/app/presenter/home/widgets/product_list_item.dart';
import 'package:natural_app/app/presenter/home/widgets/row_button_store.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';
import 'package:natural_app/app/core/shared/constants/constants.dart';

class SliverGridCustom extends StatelessWidget {
  final List<ProductModel> products;
  final void Function(int) decrement;
  final void Function(int) increment;
  final void Function(int, ProductModel) addProduct;

  const SliverGridCustom({
    super.key,
    required this.products,
    required this.decrement,
    required this.increment,
    required this.addProduct,
  });

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text('Nenhum produto foi encontado!'),
            ),
          )
        : SliverGrid.builder(
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
                color: Colors.white,
                elevation: 0,
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: CachedNetworkImage(
                          width: 100,
                          imageUrl:
                              ConstantsUrls.awsStorageImage + product.image,
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
                            product: product,
                            decrement: () => decrement(index),
                            increment: () => increment(index),
                            addProduct: () => addProduct(index, product),
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

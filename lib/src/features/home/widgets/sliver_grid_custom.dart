import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:natural_app/src/features/home/data/models/product_model.dart';
import 'package:natural_app/src/features/home/store/home_store.dart';
import 'package:natural_app/src/features/home/widgets/product_list_item.dart';
import 'package:natural_app/src/features/home/widgets/row_button_store.dart';
import 'package:natural_app/src/helpers/colors/app_colors.dart';
import 'package:natural_app/src/helpers/constants/constants.dart';

class SliverGridCustom extends StatelessWidget {
  final HomeStore store;
  final List<ProductModel> products;

  const SliverGridCustom({
    super.key,
    required this.store,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text('Carrinho está vazio'),
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
                            store: store,
                            product: product,
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

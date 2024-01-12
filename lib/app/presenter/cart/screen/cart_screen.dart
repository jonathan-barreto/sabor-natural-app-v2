import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';
import 'package:natural_app/app/presenter/cart/state/cart_state.dart';
import 'package:natural_app/app/presenter/cart/store/cart_store.dart';
import 'package:natural_app/app/data/model/product_model.dart';
import 'package:natural_app/app/init/init.dart';
import 'package:natural_app/app/core/state/raw_state.dart';
import 'package:natural_app/app/presenter/cart/widgets/delete_products_modal.dart';
import 'package:natural_app/app/presenter/cart/widgets/empty_cart.dart';
import 'package:natural_app/app/presenter/cart/widgets/list_view_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartStore cartStore = getIt<CartStore>();
  // late final Function clearCartFunction;

  @override
  void initState() {
    super.initState();
    cartStore.fetchProducts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // clearCartFunction = ModalRoute.of(context)!.settings.arguments as Function;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = [];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Carrinho',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await DeleteProductsCustom(
                parentContext: context,
              ).show();

              cartStore.clearProducts();
              // clearCartFunction();
            },
            icon: const Icon(
              Icons.close,
            ),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: cartStore,
        builder: (BuildContext context, RawState value, Widget? child) {
          if (value is LoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (value is SuccessState<CartState>) {
            final List<ProductModel> products = value.output.products;
            return products.isNotEmpty
                ? ListViewCart(
                    products: products,
                    increment: (p0, p1) {},
                  )
                : const EmptyCart();
          }

          return Container();
        },
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 60,
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'R\$ 25,00',
                      style: GoogleFonts.poppins(
                        color: AppColors.secondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'PAGAR',
                        style: GoogleFonts.poppins(
                          color: AppColors.secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: AppColors.secondColor,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

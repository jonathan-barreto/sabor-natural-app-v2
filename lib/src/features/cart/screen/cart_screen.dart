import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_app/init.dart';
import 'package:natural_app/src/features/cart/state/cart_state.dart';
import 'package:natural_app/src/features/cart/store/cart_store.dart';
import 'package:natural_app/src/features/cart/widgets/row_products_cart.dart';
import 'package:natural_app/src/helpers/colors/app_colors.dart';
import 'package:natural_app/src/states/raw_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartStore cartStore = getIt<CartStore>();

  @override
  void initState() {
    super.initState();
    cartStore.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorSearchBar,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Carrinho',
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              cartStore.clearProducts();
            },
            icon: const Icon(
              Icons.delete,
            ),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: cartStore,
        builder: (context, value, child) {
          if (value is LoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (value is SuccessState<CartState>) {
            return ListView.separated(
              itemCount: value.output.products.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final product = value.output.products[index];
                return RowProductsCart(product: product);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}

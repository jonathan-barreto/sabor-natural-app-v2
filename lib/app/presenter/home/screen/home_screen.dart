import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';
import 'package:natural_app/app/data/model/product_model.dart';
import 'package:natural_app/app/presenter/home/state/home_state.dart';
import 'package:natural_app/app/presenter/home/store/home_store.dart';
import 'package:natural_app/app/init/init.dart';

import 'package:natural_app/app/core/state/raw_state.dart';
import 'package:natural_app/app/presenter/home/widgets/bottom_loading.dart';
import 'package:natural_app/app/presenter/home/widgets/shimmer_loading.dart';
import 'package:natural_app/app/presenter/home/widgets/sliver_grid_custom.dart';
import 'package:natural_app/app/presenter/home/widgets/user_profile_search_list.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final void Function() onPressed;

  const HomeScreen({
    super.key,
    required this.name,
    required this.onPressed,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = getIt<HomeStore>();
  final TextEditingController textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    homeStore.fetchProducts();

    _scrollController.addListener(() {
      final position = _scrollController.position;

      if (position.pixels == position.maxScrollExtent) {
        homeStore.fetchMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void clearRequest() {
    homeStore.clearSearch();
  }

  void searchRequest(String search) {
    homeStore.fetchSearchProducts(search: search);
  }

  void snackBar({required String text, required bool error}) {
    final SnackBar snackBar = SnackBar(
      backgroundColor: error ? Colors.redAccent : AppColors.primaryColor,
      content: Text(
        text,
        style: GoogleFonts.poppins(
          color: AppColors.secondColor,
        ),
      ),
      action: SnackBarAction(
        label: 'Ok',
        textColor: AppColors.secondColor,
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void decrement(int index) {
    final int quantity = homeStore.decrementQuantityProduct(
      index: index,
    );

    if (quantity == 0) {
      snackBar(
        text: 'Não é possível reduzir abaixo de zero!',
        error: true,
      );
    }
  }

  void increment(int index) {
    homeStore.incrementQuantityProduct(
      index: index,
    );
  }

  void addProduct(int index, ProductModel product) async {
    final int quantity = product.quantity ?? 0;

    if (quantity != 0) {
      await homeStore.addItemToCart(
        index,
        product.id,
        quantity,
      );

      snackBar(
        text: 'Produto adicionado ao carrinho!',
        error: false,
      );

      widget.onPressed();
    } else {
      snackBar(
        text: 'Para adicionar um produto ao carrinho, a quantidade mínima é 1.',
        error: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: homeStore,
      builder: (context, value, child) {
        if (value is LoadingState) {
          return const ShimmerLoading();
        }

        if (value is SuccessState<HomeState>) {
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        UserProfileSearchList(
                          onChanged: searchRequest,
                          onPressed: clearRequest,
                          textController: textController,
                        ),
                        value.output.searchProductLoading
                            ? SliverFillRemaining(
                                hasScrollBody: false,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              )
                            : SliverGridCustom(
                                products: value.output.products,
                                decrement: decrement,
                                increment: increment,
                                addProduct: addProduct,
                              )
                      ],
                    ),
                    if (value.output.moreProductLoading) const BottomLoading(),
                  ],
                ),
              )
            ],
          );
        }

        return Container();
      },
    );
  }
}

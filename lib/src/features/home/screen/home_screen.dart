import 'package:flutter/material.dart';
import 'package:natural_app/init.dart';
import 'package:natural_app/src/features/home/state/home_state.dart';
import 'package:natural_app/src/features/home/store/home_store.dart';
import 'package:natural_app/src/features/home/widgets/sliver_grid_custom.dart';
import 'package:natural_app/src/features/home/widgets/user_profile_search_list.dart';
import 'package:natural_app/src/helpers/colors/app_colors.dart';
import 'package:natural_app/src/states/raw_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = getIt<HomeStore>();
  final SearchController controller = SearchController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    homeStore.fetchProducts(isFirstFetch: true);

    _scrollController.addListener(() {
      final position = _scrollController.position;

      if (position.pixels == position.maxScrollExtent) {
        homeStore.fetchProducts(isFirstFetch: false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void incrementFunction(int index) {
    homeStore.incrementQuantityProduct(
      index: index,
    );
  }

  void decrementFunction(int index) {
    homeStore.decrementQuantityProduct(
      index: index,
    );
  }

  void addItemToCart(int index, int id, int quantity) {
    homeStore.addItemToCart(
      index: index,
      id: id,
      quantity: quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: homeStore,
      builder: (context, value, child) {
        if (value is LoadingState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          );
        }

        if (value is SuccessState<HomeState>) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                ),
              ),
              actions: [
                SizedBox(
                  width: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                        icon: const Icon(
                          Icons.store_rounded,
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 10,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text('${value.output.totalItemsInCart}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
              backgroundColor: AppColors.primaryColor,
            ),
            body: Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    UserProfileSearchList(
                      controller: controller,
                      updateParent: (text) {
                        setState(() {
                          controller.closeView(text);
                        });
                      },
                    ),
                    SliverGridCustom(
                      products: value.output.products,
                      incrementFunction: incrementFunction,
                      decrementFunction: decrementFunction,
                      addItemToCart: addItemToCart,
                    )
                  ],
                ),
                if (value.output.showLoading)
                  Positioned(
                    left: (MediaQuery.of(context).size.width / 2) - 20,
                    bottom: 24,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}

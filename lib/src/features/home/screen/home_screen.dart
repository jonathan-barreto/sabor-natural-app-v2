import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final TextEditingController textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    homeStore.fetchProducts(isFirstFetch: true);

    _scrollController.addListener(() {
      final position = _scrollController.position;

      if (position.pixels == position.maxScrollExtent) {
        homeStore.fetchProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void clearRequest() {
    String url = 'http://127.0.0.1:8000/api/products';
    homeStore.fetchProducts(fetchRequest: true, url: url);
  }

  void searchRequest(String search) {
    String url = 'http://127.0.0.1:8000/api/products/name/$search';
    homeStore.fetchProducts(fetchRequest: true, url: url);
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
              title: Text(
                'Sabor Natural',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
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
            body: Column(
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
                          value.output.productLoading
                              ? SliverToBoxAdapter(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                )
                              : SliverGridCustom(
                                  store: homeStore,
                                  products: value.output.products,
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
                )
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}

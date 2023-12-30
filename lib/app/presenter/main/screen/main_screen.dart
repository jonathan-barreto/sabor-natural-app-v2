import 'package:flutter/material.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';
import 'package:natural_app/app/core/state/raw_state.dart';
import 'package:natural_app/app/init/init.dart';
import 'package:natural_app/app/presenter/cart/widgets/cart_icon.dart';
import 'package:natural_app/app/presenter/home/screen/home_screen.dart';
import 'package:natural_app/app/presenter/main/state/main_state.dart';
import 'package:natural_app/app/presenter/main/store/main_store.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainStore store = getIt<MainStore>();
  late final List<Widget> listWidgets;

  void updateCart() {
    store.updateCart();
  }

  @override
  void initState() {
    super.initState();

    store.initial();

    listWidgets = <Widget>[
      HomeScreen(
        name: 'Jonathan',
        onPressed: updateCart,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.green,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: store,
      builder: (context, value, child) {
        if (value is SuccessState<MainState>) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColorSearchBar,
            appBar: AppBar(
              title: const Text('Sabor Natural'),
              actions: [
                CartIcon(
                  quantity: value.output.quantity ?? 0,
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      '/cart',
                      arguments: updateCart
                    );
                  },
                ),
              ],
            ),
            body: listWidgets[value.output.indexSelected!],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: '',
                ),
              ],
              currentIndex: value.output.indexSelected!,
              onTap: (int index) {
                store.selectIndex(
                  index: index,
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}

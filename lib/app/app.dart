import 'package:flutter/material.dart';
import 'package:natural_app/app/core/shared/theme/theme_data_custom.dart';
import 'package:natural_app/app/presenter/cart/screen/cart_screen.dart';
import 'package:natural_app/app/presenter/main/screen/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeDataCustom,
      initialRoute: '/main',
      routes: {
        '/main': (context) => const MainScreen(),
        '/cart':(context) => const CartScreen(),
      },
    );
  }
}

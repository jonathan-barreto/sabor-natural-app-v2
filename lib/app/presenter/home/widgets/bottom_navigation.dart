import 'package:flutter/material.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';

class BottomNavigation extends StatelessWidget {
  final int index;
  final void Function(int) onPressed;

  const BottomNavigation({
    super.key,
    required this.index,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_sharp),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.storefront),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          label: '',
        ),
      ],
      currentIndex: index,
      selectedItemColor: AppColors.primaryColor,
      onTap: (value) {
        onPressed(value);
      },
    );
  }
}

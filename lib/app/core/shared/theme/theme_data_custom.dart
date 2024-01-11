import 'package:flutter/material.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

final themeDataCustom = ThemeData(
  primaryColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      color: AppColors.secondColor,
      fontSize: 20,
    ),
    backgroundColor: AppColors.primaryColor,
    iconTheme: IconThemeData(
      color: AppColors.secondColor,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: AppColors.secondColor,
    selectedIconTheme: IconThemeData(
      color: AppColors.primaryColor,
    ),
  ),
);

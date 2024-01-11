import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/melancia.gif'),
          Text(
            'O carrinho está vazio...',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: AppColors.primaryColorText,
            ),
          )
        ],
      ),
    );
  }
}

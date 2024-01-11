import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';

class ColumnTexts extends StatelessWidget {
  const ColumnTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Olá, Jonathan!',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColorText,
                ),
              ),
              Image.asset(
                'assets/hello.png',
                width: 30,
              ),
            ],
          ),
          Text(
            'Seja bem-vindo(a)',
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppColors.secondColorText,
            ),
          )
        ],
      ),
    );
  }
}

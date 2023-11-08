import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_app/src/features/home/widgets/profile_header.dart';

import 'package:natural_app/src/helpers/colors/app_colors.dart';

class UserProfileSearchList extends StatelessWidget {
  const UserProfileSearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          color: Colors.white,
          child: Column(
            children: [
              const ProfileHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  cursorColor: AppColors.secondColorText,
                  style: GoogleFonts.poppins(
                    color: AppColors.secondColorText,
                  ),
                  decoration: InputDecoration(
                    label: Text(
                      'Pesquisar...',
                      style: GoogleFonts.poppins(
                        color: AppColors.secondColorText,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: AppColors.secondColorText,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.secondColorText,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.secondColorText,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';

class BottomLoading extends StatelessWidget {
  const BottomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}

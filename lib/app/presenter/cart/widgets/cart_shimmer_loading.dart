import 'package:flutter/material.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class CartShimmerLoading extends StatelessWidget {
  const CartShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: ListView.separated(
        itemCount: 4,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: 150,
            color: AppColors.primaryColor,
          );
        },
      ),
    );
  }
}

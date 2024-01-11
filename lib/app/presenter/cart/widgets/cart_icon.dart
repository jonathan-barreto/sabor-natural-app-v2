import 'package:flutter/material.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';

class CartIcon extends StatelessWidget {
  final int quantity;
  final VoidCallback onPressed;

  const CartIcon({
    super.key,
    required this.quantity,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 50,
        child: Container(
          width: 25,
          height: 25,
          color: Colors.transparent,
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/cart.png',
                ),
              ),
              Positioned(
                left: 25,
                bottom: 5,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$quantity',
                      style: TextStyle(
                        color: AppColors.secondColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

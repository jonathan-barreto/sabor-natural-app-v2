import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_app/src/features/home/data/models/product_model.dart';
import 'package:natural_app/src/helpers/colors/app_colors.dart';

class RowButtonStore extends StatelessWidget {
  final int index;
  final ProductModel product;
  final Function(int) incrementFunction;
  final Function(int) decrementFunction;
  final Function(int, int, int) addItemToCart;

  const RowButtonStore({
    super.key,
    required this.index,
    required this.product,
    required this.incrementFunction,
    required this.decrementFunction,
    required this.addItemToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => decrementFunction(index),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.secondColor,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.remove,
                      ),
                    ),
                  ),
                ),
                Text(
                  '${product.quantity}',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColorText,
                  ),
                ),
                GestureDetector(
                  onTap: () => incrementFunction(index),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: AppColors.secondColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => addItemToCart(
                index,
                product.id,
                product.quantity ?? 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xff222222),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Image.asset('assets/carrinho.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

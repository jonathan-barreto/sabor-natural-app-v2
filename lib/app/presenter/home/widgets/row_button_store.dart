import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_app/app/data/model/product_model.dart';


import 'package:natural_app/app/core/shared/colors/app_colors.dart';

class RowButtonStore extends StatelessWidget {
  final ProductModel product;
  final VoidCallback decrement;
  final VoidCallback increment;
  final VoidCallback addProduct;

  const RowButtonStore({
    super.key,
    required this.product,
    required this.decrement,
    required this.increment,
    required this.addProduct,
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
                  onTap: () => decrement(),
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
                  onTap: () => increment(),
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
              onTap: () => addProduct(),
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

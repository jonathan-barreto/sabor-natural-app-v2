import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_app/src/features/home/data/models/product_model.dart';
import 'package:natural_app/src/helpers/colors/app_colors.dart';
import 'package:natural_app/src/helpers/constants/constants.dart';

class RowProductsCart extends StatelessWidget {
  final ProductModel product;

  const RowProductsCart({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: CachedNetworkImage(
                  width: 60,
                  imageUrl: ConstantsUrls.fetchImage + product.image,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryColorText,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'R\$ ${product.price}',
                        style: GoogleFonts.poppins(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        ' / ${product.unit}',
                        style: GoogleFonts.poppins(
                          color: AppColors.secondColorText,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {},
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
                      onTap: () => {},
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

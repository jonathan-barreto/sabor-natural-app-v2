import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_app/app/core/shared/colors/app_colors.dart';
import 'package:natural_app/app/core/shared/widgets/bottom_modal_custom.dart';

class DeleteProductsCustom extends StatefulWidget {
  final BuildContext parentContext;

  const DeleteProductsCustom({
    super.key,
    required this.parentContext,
  });

  Future<void> _showModal() async {
    return showModalBottomSheet(
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: parentContext,
      builder: (BuildContext context) {
        return this;
      },
    );
  }

  Future<void> show() => Future<void>.microtask(() => _showModal());

  @override
  State<DeleteProductsCustom> createState() => _DeleteProductsCustomState();
}

class _DeleteProductsCustomState extends State<DeleteProductsCustom> {
  @override
  Widget build(BuildContext context) {
    return BottomModalCustom(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.redAccent,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                        backgroundColor: const MaterialStatePropertyAll(
                          Colors.redAccent,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'DELETAR',
                        style: GoogleFonts.poppins(
                          color: AppColors.secondColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(
                          AppColors.primaryColor,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'FECHAR',
                        style: GoogleFonts.poppins(
                          color: AppColors.secondColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

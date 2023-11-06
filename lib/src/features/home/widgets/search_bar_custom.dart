import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natural_app/src/helpers/colors/app_colors.dart';

class SearchBarCustom extends StatelessWidget {
  final SearchController controller;
  final void Function(String) updateParent;

  const SearchBarCustom({
    super.key,
    required this.controller,
    required this.updateParent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SearchAnchor(
        viewConstraints: const BoxConstraints(
          maxHeight: 300,
        ),
        searchController: controller,
        viewLeading: IconButton(
          onPressed: () {
            controller.closeView('');
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.secondColorText,
          ),
        ),
        viewTrailing: [
          IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: Icon(
              Icons.close,
              color: AppColors.secondColorText,
            ),
          ),
        ],
        headerTextStyle: GoogleFonts.poppins(
          color: AppColors.primaryColorText,
        ),
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        viewBackgroundColor: AppColors.backgroundColorSearchBar,
        builder: (context, controller) {
          return SearchBar(
            controller: controller,
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            elevation: const MaterialStatePropertyAll(0),
            hintText: 'Pesquisar',
            textStyle: MaterialStatePropertyAll(
              GoogleFonts.poppins(
                color: const Color(0xffB4AFAF),
              ),
            ),
            hintStyle: MaterialStatePropertyAll(
              GoogleFonts.poppins(
                color: const Color(0xffB4AFAF),
              ),
            ),
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                color: Color(0xffB4AFAF),
              ),
            ),
            backgroundColor: MaterialStatePropertyAll(
              AppColors.backgroundColorSearchBar,
            ),
            onTap: () => controller.openView(),
          );
        },
        suggestionsBuilder: (context, controller) {
          return List<ListTile>.generate(
            5,
            (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () => updateParent(item),
              );
            },
          );
        },
      ),
    );
  }
}

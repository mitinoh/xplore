import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/presentation/screen/search/widget/mdl_category.dart';

class SearchTopBarWidget extends StatelessWidget {
  SearchTopBarWidget({Key? key}) : super(key: key);
  late ThemeData themex;
  @override
  Widget build(BuildContext context) {
    themex = Theme.of(context);
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      elevation: 0,
      centerTitle: true,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      backgroundColor: themex.scaffoldBackgroundColor,
      iconTheme: IconThemeData(color: themex.primaryColor),
      actionsIconTheme: IconThemeData(color: themex.primaryColor),
      leading: GestureDetector(
          onTap: () => {Navigator.pop(context)},
          child: Icon(Iconsax.arrow_left, color: themex.primaryColor)),
      leadingWidth: 23,
      title: Text(
        "Cerca",
        style: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.w600, color: themex.primaryColor),
      ),
      actions: [
        InkWell(
            onTap: () => {_categoryModal()},
            child: Icon(Iconsax.setting_4, color: themex.primaryColor)),
      ],
    );
  }

  Widget _categoryModal() {
    return CategoryModal();
  }
}

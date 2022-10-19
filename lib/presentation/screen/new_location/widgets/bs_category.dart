import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/presentation/common_widgets/gridView_category_preference.dart';

class CategoriesBottomSheet extends StatefulWidget {
  CategoriesBottomSheet({
    Key? key,
    required this.selectedCategories,
    this.callback,
  }) : super(key: key);

  final List<LocationCategoryModel> selectedCategories;
  final void Function(List<LocationCategoryModel>)? callback;

  @override
  State<CategoriesBottomSheet> createState() => _CategoriesBottomSheetState();
}

class _CategoriesBottomSheetState extends State<CategoriesBottomSheet> {
  late MediaQueryData mediaQueryX = MediaQuery.of(context);
  late ThemeData themex = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediaQueryX.size.height * 0.6,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: themex.backgroundColor,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Apply categories',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: themex.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "Select the categories that best suit what you are adding, don't be afraid to make a mistake 😁",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                GridViewCategoryPreference(
                  selectedCategories: widget.selectedCategories,
                  updateSelectedCategories: _setSelectedCategories,
                )
              ]),
        ),
      ),
    );
  }

  void _setSelectedCategories(List<LocationCategoryModel> categoryList) {
    widget.callback!(categoryList);
  }
}

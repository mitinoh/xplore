import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/presentation/screen/new_location/bloc/bloc.dart';
import 'package:xplore/presentation/screen/new_location/widgets/bs_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<LocationCategoryModel> _selectedCategories = [];

  late ThemeData themex = Theme.of(context);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _showCategoryBottomSheet();
          },
          child: Container(
            padding: const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: themex.cardColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 15),
                  child: Icon(
                    Iconsax.hashtag,
                    color: themex.indicatorColor,
                  ),
                ),
                Text(
                  selectedCategory,
                  style: GoogleFonts.poppins(fontSize: 14, color: themex.disabledColor),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  String _getSelectedCategoriesName() {
    String categories = '';
    _selectedCategories.forEach((c) => categories += '${c.name}, ');
    return categories;
  }

  void _setSelectedCategories(List<LocationCategoryModel> categoriesList) {
    setState(() {
      _selectedCategories = categoriesList;
    });

    BlocProvider.of<NewLocationBloc>(context).newLocation.locationCategory =
        categoriesList;
  }

  void _showCategoryBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return CategoriesBottomSheet(
              selectedCategories: _selectedCategories, callback: _setSelectedCategories);
        });
  }

  String get selectedCategory {
    return _selectedCategories.isEmpty
        ? "Add categories"
        : _getSelectedCategoriesName();
  }
}

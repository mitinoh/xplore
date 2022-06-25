import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/widget_core.dart';
import 'package:xplore/model/location_category_model.dart';

class CategoriesBottomSheet extends StatefulWidget {
  CategoriesBottomSheet({Key? key, required this.locCatBloc}) : super(key: key);
  LocationcategoryBloc locCatBloc = new LocationcategoryBloc();
  List<String> catSelected = [];
  @override
  State<CategoriesBottomSheet> createState() => _CategoriesBottomSheetState();
}

class _CategoriesBottomSheetState extends State<CategoriesBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);
    return Container(
      height: mediaQuery.size.height * 0.6,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: lightDark.backgroundColor,
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
                          text: 'Applica categorie',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: lightDark.primaryColor),
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
                          "lorem ipsum is simply dummy text of the printing and typesetting industry. Versione app 1.0.1",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                locationCategories(lightDark),
              ]),
        ),
      ),
    );
  }

  BlocProvider<LocationcategoryBloc> locationCategories(lightDark) {
    return BlocProvider(
      create: (_) => widget.locCatBloc,
      child: BlocListener<LocationcategoryBloc, LocationcategoryState>(
        listener: (context, state) {
          if (state is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("error"),
              ),
            );
          }
        },
        child: BlocBuilder<LocationcategoryBloc, LocationcategoryState>(
          builder: (context, state) {
            if (state is LocationcategoryInitial ||
                state is LocationCategoryLoading) {
              return const LoadingIndicator();
            } else if (state is LocationcategoryLoaded) {
              return locationCategoriesList(state, lightDark);
            } else if (state is LocationcategoryError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  SingleChildScrollView locationCategoriesList(
      LocationcategoryLoaded state, lightDark) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Container(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.locationCategoryModel.length,
              itemBuilder: (BuildContext context, int index) {
                // TODO: da rifare con un metodo che ritorna tutto questo e non uno alla volta

                return Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: lightDark.splashColor,
                  ),
                  child: Theme(
                    data: ThemeData(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        unselectedWidgetColor: Colors.grey.withOpacity(0.3)),
                    child: CheckboxListTile(
                      checkColor: UIColors.lightGreen,
                      activeColor: UIColors.lightGreen,
                      value: _categoryIsSelected(
                          state.locationCategoryModel, index),
                      onChanged: (bln) {
                        _toggleSelectedCat(state.locationCategoryModel, index);
                      },
                      title: Text(
                          _getLocationName(state.locationCategoryModel, index),
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _categoryIsSelected(
      List<LocationCategoryModel> locationCategoryModel, int index) {
    return widget.catSelected.contains(locationCategoryModel[index].iId);
  }

  void _toggleSelectedCat(
      List<LocationCategoryModel> locationCategoryModel, int index) {
    setState(() {
      String value = locationCategoryModel[index].iId ?? '';
      if (widget.catSelected.contains(value)) {
        widget.catSelected.remove(value);
      } else {
        widget.catSelected.add(value);
      }
    });
  }

  String _getLocationName(
      List<LocationCategoryModel> locationCategoryModel, int index) {
    return locationCategoryModel[index].name ?? '';
  }
}

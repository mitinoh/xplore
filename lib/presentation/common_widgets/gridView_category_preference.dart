import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/data/repository/location_category_repository.dart';
import 'package:xplore/presentation/common_widgets/sb_error.dart';
import 'package:xplore/presentation/common_widgets/wg_error.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/home/bloc_location_category/bloc.dart';

class GridViewCategoryPreference extends StatefulWidget {
  GridViewCategoryPreference(
      {Key? key,
      required this.selectedCategories,
      required this.updateSelectedCategories})
      : super(key: key);

  List<LocationCategoryModel> selectedCategories;
  final ValueChanged<List<LocationCategoryModel>> updateSelectedCategories;
  @override
  State<GridViewCategoryPreference> createState() => _GridViewCategoryPreference();
}

class _GridViewCategoryPreference extends State<GridViewCategoryPreference> {
  @override
  void initState() {
    super.initState();
  }

  late ThemeData themex = Theme.of(context);
  late MediaQueryData mediaQueryX = MediaQuery.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationCategoryBloc(
          locationCategroyRepository:
              RepositoryProvider.of<LocationCategoryRepository>(context))
        ..add(GetLocationCategoryList()),
      child: BlocListener<LocationCategoryBloc, LocationCategoryState>(
        listener: (context, state) {
          if (state is LocationCategoryError) {
            SbError().show(context);
          }
        },
        child: BlocBuilder<LocationCategoryBloc, LocationCategoryState>(
          builder: (context, state) {
            if (state is LocationCategoryLoading) {
              return const LoadingIndicator();
            } else if (state is LocationCategoryLoaded) {
              return SizedBox(
                height: mediaQueryX.size.height * 0.38,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 1,
                      mainAxisExtent: 57),
                  shrinkWrap: true,
                  itemCount: state.locationCategoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      //margin: const EdgeInsets.only(bottom: 5),
                      //padding: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: themex.cardColor,
                      ),
                      child: Theme(
                        data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            unselectedWidgetColor: themex.unselectedWidgetColor),
                        child: CheckboxListTile(
                          checkColor: themex.primaryColor,
                          activeColor: themex.primaryColor,
                          //value: true,
                          value: widget.selectedCategories
                              .contains(state.locationCategoryList[index]),
                          // value: CategoryPreference.catSelected.contains(state.locationCategoryList[index].iId),
                          onChanged: (bln) {
                            LocationCategoryModel category =
                                state.locationCategoryList[index];
                            setState(() {
                              if (widget.selectedCategories.contains(category))
                                widget.selectedCategories.remove(category);
                              else
                                widget.selectedCategories.add(category);

                              widget.updateSelectedCategories(widget.selectedCategories);
                            });
                          },
                          title: Text(state.locationCategoryList[index].name ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: themex.indicatorColor)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return ErrorScreen(state: state);
            }
          },
        ),
      ),
    );
  }

  bool getValue(LocationCategoryLoaded state, int index) {
    LocationCategoryModel category = state.locationCategoryList[index];
    List<String?> selectedId = [];

    widget.selectedCategories.forEach((sc) => selectedId.add(sc.id));
    return selectedId.contains(category.id ?? '');
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/widget_core.dart';

class CategoryPreference extends StatefulWidget {
  const CategoryPreference({Key? key}) : super(key: key);
  static List<String> catSelected = [];
  @override
  State<CategoryPreference> createState() => _CategoryPreferenceState();
}

class _CategoryPreferenceState extends State<CategoryPreference> {
  final LocationCategoryBloc _locCatBloc = LocationCategoryBloc();

  @override
  void initState() {
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return BlocProvider(
      create: (_) => _locCatBloc,
      child: BlocListener<LocationCategoryBloc, LocationcategoryState>(
        listener: (context, state) {
          if (state is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("error"),
              ),
            );
          }
        },
        child: BlocBuilder<LocationCategoryBloc, LocationcategoryState>(
          builder: (context, state) {
            if (state is LocationcategoryInitial) {
              return const LoadingIndicator();
            } else if (state is LocationCategoryLoading) {
              return const LoadingIndicator();
            } else if (state is LocationcategoryLoaded) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.locationCategoryModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: lightDark.cardColor,
                    ),
                    child: Theme(
                      data: ThemeData(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          unselectedWidgetColor:
                              lightDark.unselectedWidgetColor),
                      child: CheckboxListTile(
                        checkColor: UIColors.lightGreen,
                        activeColor: UIColors.lightGreen,
                        value: CategoryPreference.catSelected
                            .contains(state.locationCategoryModel[index].iId),
                        onChanged: (bln) {
                          setState(() {
                            String value =
                                state.locationCategoryModel[index].iId ?? '';
                            if (CategoryPreference.catSelected
                                .contains(value)) {
                              CategoryPreference.catSelected.remove(value);
                            } else {
                              CategoryPreference.catSelected.add(value);
                            }
                          });
                        },
                        title: Text(
                            state.locationCategoryModel[index].name ?? '',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: lightDark.primaryColor)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                      ),
                    ),
                  );
                },
              );
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
}

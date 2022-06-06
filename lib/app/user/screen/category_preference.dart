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
  final LocationcategoryBloc _locCatBloc = LocationcategoryBloc();

  @override
  void initState() {
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: BlocProvider(
        create: (_) => _locCatBloc,
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
              if (state is LocationcategoryInitial) {
                return const LoadingIndicator();
              } else if (state is LocationCategoryLoading) {
                return const LoadingIndicator();
              } else if (state is LocationcategoryLoaded) {
                return SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: mediaQuery.size.height * 0.4,
                        child: ListView.builder(
                          itemCount: state.locationCategoryModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(2.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: UIColors.grey.withOpacity(0.3),
                              ),
                              child: Theme(
                                data: ThemeData(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    unselectedWidgetColor:
                                        Colors.grey.withOpacity(0.3)),
                                child: CheckboxListTile(
                                  checkColor: UIColors.lightGreen,
                                  activeColor: UIColors.lightGreen,
                                  value: CategoryPreference.catSelected
                                      .contains(state
                                          .locationCategoryModel[index].iId),
                                  onChanged: (bln) {
                                    setState(() {
                                      String value = state
                                              .locationCategoryModel[index]
                                              .iId ??
                                          '';
                                      if (CategoryPreference.catSelected
                                          .contains(value)) {
                                        CategoryPreference.catSelected
                                            .remove(value);
                                      } else {
                                        CategoryPreference.catSelected
                                            .add(value);
                                      }
                                    });
                                  },
                                  title: Text(
                                      state.locationCategoryModel[index].name ??
                                          '',
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
                      ),
                      /*TextButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                NewUser(_catSelected),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                              );
                            },
                            child: Text("done"))
                            */
                    ],
                  ),
                );
              } else if (state is LocationcategoryError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

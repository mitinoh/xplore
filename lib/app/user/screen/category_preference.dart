import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/core/widget/widget_core.dart';

class CategoryPreference extends StatefulWidget {
  CategoryPreference({Key? key}) : super(key: key);
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
                return LoadingIndicator();
              } else if (state is LocationCategoryLoading) {
                return LoadingIndicator();
              } else if (state is LocationcategoryLoaded) {
                return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.locationCategoryModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CheckboxListTile(
                            value: CategoryPreference.catSelected.contains(
                                state.locationCategoryModel[index].iId),
                            onChanged: (bln) {
                              setState(() {
                                String value =
                                    state.locationCategoryModel[index].iId ??
                                        '';
                                if (CategoryPreference.catSelected
                                    .contains(value)) {
                                  CategoryPreference.catSelected.remove(value);
                                } else {
                                  CategoryPreference.catSelected.add(value);
                                }
                              });
                            },
                            title: Text(
                                state.locationCategoryModel[index].name ?? ''),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          );
                        },
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

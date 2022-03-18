import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/core/widget/navbar.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/main.dart';

class CategoryPreference extends StatefulWidget {
  const CategoryPreference({Key? key}) : super(key: key);

  @override
  State<CategoryPreference> createState() => _CategoryPreferenceState();
}

class _CategoryPreferenceState extends State<CategoryPreference> {
  final LocationcategoryBloc _locCatBloc = LocationcategoryBloc();
  List<int> _catSelected = [];

  @override
  void initState() {
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => _locCatBloc,
          child: BlocListener<LocationcategoryBloc, LocationcategoryState>(
            listener: (context, state) {
              if (state is HomeError) {
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
                              value: _catSelected.contains(
                                  state.locationCategoryModel[index].value),
                              onChanged: (bln) {
                                setState(() {
                                  int value = state
                                          .locationCategoryModel[index].value ??
                                      0;
                                  if (_catSelected.contains(value)) {
                                    _catSelected.remove(value);
                                  } else {
                                    _catSelected.add(value);
                                  }
                                });
                              },
                              title: Text(
                                  state.locationCategoryModel[index].name ??
                                      ''),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            );
                          },
                        ),
                        TextButton(
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
      ),
    );
  }
}

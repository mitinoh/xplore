import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
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
                  return Column(
                    children: [
                      /* ListView.builder(
                                itemCount: state.locationCategoryModel.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(state.locationCategoryModel[index].name ?? '');
                                },
                              
                              ),*/
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(
                              NewUserRegistered(),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                          child: Text("done"))
                    ],
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

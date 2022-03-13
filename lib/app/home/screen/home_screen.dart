import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/home/widget/widget_home.dart';
import 'package:xplore/app/locationCategory/bloc/locationcategory_bloc.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/locationCategory_model.dart';
import 'package:xplore/model/location_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = HomeBloc();
  final LocationcategoryBloc _locCatBloc = LocationcategoryBloc();
  final PageController _pageController = PageController();

  @override
  void initState() {
    _homeBloc.add(GetLocationList());
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        BuildListCardHome(
          homeBloc: _homeBloc,
          pageController: _pageController,
        ),
        SafeArea(
          child: TopMenuHome(
            context: context,
            homeBloc: _homeBloc,
            locCatBloc: _locCatBloc,
          ),
        )
      ]),
    );
  }
}

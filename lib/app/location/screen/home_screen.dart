import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location/widget/widget_home.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationBloc _homeBloc = LocationBloc();
  final LocationcategoryBloc _locCatBloc = LocationcategoryBloc();
  final PageController _pageController = PageController();

  @override
  void initState() {
    _homeBloc.add(const GetLocationList(add: true));
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  double _height = 85;
  late bool _valore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F7FA),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Stack(children: [
          BuildListCardHome(
            homeBloc: _homeBloc,
            pageController: _pageController,
          ),
        ]),
      ),
    );
  }
}

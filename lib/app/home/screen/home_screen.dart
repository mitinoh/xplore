import 'package:flutter/material.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/home/widget/list_card_widget.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';

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
    _homeBloc.add(const GetLocationList());
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return Text(AppLocalizations.of(context)!.helloWorld);
    return Scaffold(
      backgroundColor: const Color(0xffF3F7FA),
      body: SafeArea(
        top: false,
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

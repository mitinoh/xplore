import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/home/widget/pinned_menu_widget.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/location_model.dart';

/*
class TopMenuHome extends StatelessWidget {
  const TopMenuHome(
      {Key? key,
      required this.context,
      required this.locCatBloc,
      required this.homeBloc})
      : super(key: key);
  final BuildContext context;
  final LocationcategoryBloc locCatBloc;
  final HomeBloc homeBloc;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SearchMenuHome(homeBloc: homeBloc),
        FilterMenuHome(
            context: context, locCatBloc: locCatBloc, homeBloc: homeBloc),
      ],
    );
  }
}
class FilterMenuHome extends StatelessWidget {
  const FilterMenuHome(
      {Key? key,
      required this.context,
      required this.locCatBloc,
      required this.homeBloc})
      : super(key: key);
  final BuildContext context;
  final LocationcategoryBloc locCatBloc;
  final HomeBloc homeBloc;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () {
          showModalBottomSheet<void>(
              useRootNavigator: true,
              context: context,
              builder: (BuildContext context) {
                return BlocProvider(
                  create: (_) => locCatBloc,
                  child:
                      BlocListener<LocationcategoryBloc, LocationcategoryState>(
                    listener: (context, state) {
                      if (state is LocationError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("error"),
                          ),
                        );
                      }
                    },
                    child: BlocBuilder<LocationcategoryBloc,
                        LocationcategoryState>(
                      builder: (context, state) {
                        if (state is LocationcategoryInitial ||
                            state is LocationCategoryLoading) {
                          return const LoadingIndicator();
                        } else if (state is LocationcategoryLoaded) {
                          return BuildListCardCategory(
                            context: context,
                            model: state.locationCategoryModel,
                            homeBloc: homeBloc,
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
              });
          // _homeBloc.add(SetFilterLocationList(amount: "string"));
        },
        icon: const Icon(Icons.menu),
      ),
    );
  }
}

*/

/*
class SearchMenuHome extends StatefulWidget {
  const SearchMenuHome({Key? key, required this.homeBloc}) : super(key: key);
  final HomeBloc homeBloc;

  @override
  State<SearchMenuHome> createState() => _SearchMenuHomeState();
}

class _SearchMenuHomeState extends State<SearchMenuHome>
    with SingleTickerProviderStateMixin {
  _SearchMenuHomeState();
  late Animation<double> animation;
  late AnimationController animController;
  bool isForward = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    final curvedAnimation =
        CurvedAnimation(parent: animController, curve: Curves.linear);

    animation = Tween<double>(begin: 0, end: 150).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Row(
        children: [
          Container(
            width: animation.value < 200 ? animation.value : 150,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50)),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: _searchController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                //  decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
          Container(
            width: 50,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            child: IconButton(
              icon: Icon(
                Iconsax.search_normal,
                color: UIColors.violet,
              ),
              color: Colors.white,
              onPressed: () {
                if (!isForward) {
                  animController.forward();
                  isForward = true;
                } else {
                  //HomeRepository.skip = 1;
                  widget.homeBloc.add(GetLocationList(
                      searchName: _searchController.text.toString(),
                      add: false));
                  animController.reverse();
                  isForward = false;
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
*/
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location/repository/location_repository.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/locationCategory_model.dart';
import 'package:xplore/model/location_model.dart';

class TopMenuHome extends StatelessWidget {
  const TopMenuHome(
      {Key? key,
      required this.context,
      required this.locCatBloc,
      required this.homeBloc})
      : super(key: key);
  final BuildContext context;
  final LocationcategoryBloc locCatBloc;
  final LocationBloc homeBloc;
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
  final LocationBloc homeBloc;
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

class BuildListCardCategory extends StatelessWidget {
  const BuildListCardCategory(
      {Key? key,
      required this.context,
      required this.model,
      required this.homeBloc})
      : super(key: key);
  final BuildContext context;
  final List<LocationCategory> model;
  final LocationBloc homeBloc;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (BuildContext context, int index) {
        return TextButton(
            onPressed: () {
              toggleCategoryFilter(index);
              homeBloc.add(const GetLocationList());
            },
            child: Text(model[index].name ?? ''));
      },
    );
  }

  toggleCategoryFilter(int index) {
    if (LocationRepository.categoryFilter.contains(model[index].value)) {
      LocationRepository.categoryFilter.remove(model[index].value);
    } else {
      LocationRepository.categoryFilter.add(model[index].value ?? 0);
    }
  }
}

class BuildListCardHome extends StatefulWidget {
  BuildListCardHome(
      {Key? key, required this.homeBloc, required this.pageController})
      : super(key: key);

  final LocationBloc homeBloc;
  final PageController pageController;

  List<Location> modelLoc = [];
  @override
  State<BuildListCardHome> createState() => _BuildListCardHomeState();
}

class _BuildListCardHomeState extends State<BuildListCardHome> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.homeBloc,
      child: BlocListener<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationHomeInitial || state is LocationHomeLoading) {
              return const LoadingIndicator();
            } else if (state is LocationHomeLoaded) {
              widget.modelLoc.addAll(state.homeModel);
              return BuildMainCard(
                  model: widget.modelLoc,
                  pageController: widget.pageController,
                  locationBloc: widget.homeBloc);
            } else if (state is LocationError) {
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

// ignore: must_be_immutable
class BuildMainCard extends StatelessWidget {
  BuildMainCard(
      {Key? key,
      required this.pageController,
      required this.model,
      required this.locationBloc})
      : super(key: key);
  final PageController pageController;
  final List<Location> model;
  final LocationBloc locationBloc;

  Config conf = Config();

  List<Widget> card = [];

  @override
  Widget build(BuildContext context) {
    getCards();
    return PageView(
      scrollDirection: Axis.vertical,
      controller: pageController,
      children: card,
      onPageChanged: (i) => {
        if (i % 10 == 0) // TODO: mettere 15
          {
            LocationRepository.skip += 1,
            locationBloc.add(const GetLocationList())
          }
      },
    );
  }

  getCards() {
    for (Location el in model) {
      String id = el.iId?.oid ?? '';
      String url = conf.locationImage + id;
      card.add(
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(url), fit: BoxFit.cover)),
            child: SafeArea(
              child: Stack(children: [
                Positioned(
                    top: 50.0,
                    child: IconButton(
                        onPressed: () {
                          saveLocation(id);
                        },
                        icon: Icon(Icons.heart_broken))),
                Center(
                  child: Text(
                    el.name ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.brown,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            )),
      );
    }
  }

  saveLocation(String id) {
    Map<String, dynamic> saveLocationMap = {
      "locationId": 'ObjectId("$id")',
    };

    locationBloc.add(SaveUserLocation(map: saveLocationMap));
  }
}

class SearchMenuHome extends StatefulWidget {
  const SearchMenuHome({Key? key, required this.homeBloc}) : super(key: key);
  final LocationBloc homeBloc;

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
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                if (!isForward) {
                  animController.forward();
                  isForward = true;
                } else {
                  LocationRepository.skip = 1;
                  widget.homeBloc.add(GetLocationList(
                    searchName: _searchController.text.toString(),
                  ));
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

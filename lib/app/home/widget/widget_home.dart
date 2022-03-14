import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/home/repository/home_repository.dart';
import 'package:xplore/app/locationCategory/bloc/locationcategory_bloc.dart';
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
  FilterMenuHome(
      {Key? key,
      required this.context,
      required this.locCatBloc,
      required this.homeBloc});
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
                      if (state is HomeError) {
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
                        if (state is LocationcategoryInitial) {
                          return LoadingIndicator();
                        } else if (state is LocationCategoryLoading) {
                          return LoadingIndicator();
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
  final HomeBloc homeBloc;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (BuildContext context, int index) {
        return TextButton(
            onPressed: () {
              if (HomeRepository.categoryFilter.contains(model[index].value))
                HomeRepository.categoryFilter.remove(model[index].value);
              else
                HomeRepository.categoryFilter.add(model[index].value ?? 0);

              homeBloc.add(GetLocationList());
            },
            child: Text(model[index].name ?? ''));
      },
    );
  }
}

class BuildListCardHome extends StatelessWidget {
  const BuildListCardHome(
      {Key? key, required this.homeBloc, required this.pageController})
      : super(key: key);

  final HomeBloc homeBloc;
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => homeBloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial) {
              return LoadingIndicator();
            } else if (state is HomeLoading) {
              return LoadingIndicator();
            } else if (state is HomeLoaded) {
              return BuildMainCard(
                model: state.homeModel,
                pageController: pageController,
              );
            } else if (state is HomeError) {
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

class BuildMainCard extends StatelessWidget {
  const BuildMainCard(
      {Key? key, required this.pageController, required this.model})
      : super(key: key);
  final PageController pageController;
  final List<Location> model;
  @override
  Widget build(BuildContext context) {
    List<Widget> _card = [];
 
    for (Location el in model) {
      String id = el.iId?.oid ?? '';
      String url = "http://localhost:8080/xplore/image/" + id;
      _card.add(Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
          child: Center(
            child: Text(
              el.name ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          )));
    }
    return PageView(
      scrollDirection: Axis.vertical,
      controller: pageController,
      children: _card,
    );
  }
}

class SearchMenuHome extends StatefulWidget {
  const SearchMenuHome({Key? key, required this.homeBloc}) : super(key: key);
  final HomeBloc homeBloc;

  @override
  State<SearchMenuHome> createState() =>
      _SearchMenuHomeState(homeBloc: homeBloc);
}

class _SearchMenuHomeState extends State<SearchMenuHome>
    with SingleTickerProviderStateMixin {
  _SearchMenuHomeState({required this.homeBloc});
  final HomeBloc homeBloc;
  late Animation<double> animation;
  late AnimationController animController;
  bool isForward = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

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
                  homeBloc.add(GetLocationList(
                      searchName: _searchController.text.toString()));
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

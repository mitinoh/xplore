import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location/widget/docker.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/location_category_model.dart';
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

*/

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
              if (state.add)
                widget.modelLoc.addAll(state.homeModel);
              else
                widget.modelLoc = state.homeModel;

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
class BuildMainCard extends StatefulWidget {
  const BuildMainCard(
      {Key? key,
      required this.pageController,
      required this.model,
      required this.locationBloc})
      : super(key: key);
  final PageController pageController;
  final List<Location> model;
  final LocationBloc locationBloc;

  @override
  State<BuildMainCard> createState() => _BuildMainCardState();
}

class _BuildMainCardState extends State<BuildMainCard> {
  Config conf = Config();
  List<Widget> card = [];
  double _height = 85;
  late bool _valore = true;
  int indexLocation = 0;

  changeIndexLocation(int i) {
    setState(() {
      indexLocation = i;
    });
  }

  @override
  void initState() {
    getCards();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        PageView(
          scrollDirection: Axis.vertical,
          controller: widget.pageController,
          children: card,
          onPageChanged: (i) => {
            changeIndexLocation(i),
            if (i % 15 == 0) // TODO: mettere 15 //FIXME
              {
                log("****"),
                //  LocationRepository.skip += 1,
                // locationBloc.add(const GetLocationList(add: true))
              }
          },
        ),
        Visibility(
          visible: _valore,
          child: Docker(
            locationList: widget.model,
            indexLocation: indexLocation,
            locationBloc: widget.locationBloc,
          ),
        ),
        Positioned(
            top: mediaQuery.size.height * 0.1,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xffF3F7FA).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text("@xplore",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
              ],
            )),
        Positioned(
          child: Column(
            children: [
              AnimatedContainer(
                height: _height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffF3F7FA).withOpacity(0.8)),
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                duration: const Duration(seconds: 1),
                curve: Curves.bounceOut,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        textScaleFactor: 1,
                        text: TextSpan(
                            text: widget.model[indexLocation].name.toString(),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                            children: const [
                              TextSpan(
                                  text:
                                      " lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black)),
                              TextSpan(
                                  text: " @xplore.",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                              TextSpan(
                                  text: "\n\n#roma #inverno #congliamici",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ]),
                      ),
                    ),
                    _valore
                        ? InkWell(
                            onTap: () => {
                                  setState(() {
                                    _height = 340;
                                    _valore = false;
                                  })
                                },
                            child: const Icon(Iconsax.maximize_4))
                        : InkWell(
                            onTap: () => {
                              setState(() {
                                _height = 85;
                                _valore = true;
                              })
                            },
                            child: Icon(Iconsax.close_circle,
                                color: UIColors.black),
                          ),
                  ],
                ),
              ),
            ],
          ),
          bottom: 0,
          right: 0,
          left: 0,
        ),
      ],
    );
  }

  getCards() {
    for (Location el in widget.model) {
      String id = el.iId ?? '';
      String url = conf.locationImage + id + '.jpg';
      card.add(Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
                onError: (obj, stackTrace) => {})),
      ));
    }
  }

  saveLocation(String id) {
    /*
    Map<String, dynamic> saveLocationMap = {
      "location": '$id',
    };

    widget.locationBloc.add(SaveUserLocation(map: saveLocationMap));
    */
  }
}
/*
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
                  //LocationRepository.skip = 1;
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
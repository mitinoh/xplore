import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:xplore/app/search_location/bloc/search_location_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/location_model.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late bool _ptGridVisible = false;
  SearchLocationBloc _searchLocationBloc = SearchLocationBloc();

  @override
  void initState() {
    log(_searchLocationBloc.isClosed.toString());
    if (!_searchLocationBloc.isClosed)
      _searchLocationBloc.add(const GetSearchLocationList(add: true));

    super.initState();
  }

  filterLocation() {
    _searchLocationBloc.add(GetSearchLocationList(
        searchName: _searchController.text.toString(), add: false));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color(0xffF3F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => {Navigator.pop(context)},
                      child: const Icon(Iconsax.arrow_left)),
                  InkWell(onTap: () => {}, child: const Icon(Iconsax.setting_4))
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                        color: UIColors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        setState(() {
                          _ptGridVisible = hasFocus;
                        });
                      },
                      child: TextFormField(
                        controller: _searchController,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15.0),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "cerca un posto",
                          hintStyle:
                              TextStyle(color: UIColors.grey, fontSize: 14),
                          border: const OutlineInputBorder(),
                          suffixIconColor: UIColors.violet,
                          prefixIcon: IconButton(
                            icon: Icon(
                              Iconsax.search_normal,
                              color: UIColors.violet,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              filterLocation();

                              _searchLocationBloc.add(GetSearchLocationList(
                                  searchName: _searchController.text.toString(),
                                  add: false));

                              //LocationRepository.skip = 1;
                            },
                          ),
                        ),
                        autofocus: false,
                      ),
                    ),
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: _ptGridVisible,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: UIColors.bluelight,
                          ),
                          const Text(
                            "Roma",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          const Icon(Iconsax.arrow_right_1)
                        ],
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: UIColors.bluelight,
                          ),
                          const Text(
                            "Bologna",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          const Icon(Iconsax.arrow_right_1)
                        ],
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: UIColors.bluelight,
                          ),
                          const Text(
                            "Genova",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          const Icon(Iconsax.arrow_right_1)
                        ],
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: UIColors.bluelight,
                          ),
                          const Text(
                            "Milano",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          const Icon(Iconsax.arrow_right_1)
                        ],
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: UIColors.bluelight,
                          ),
                          const Text(
                            "Barcellona",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          const Icon(Iconsax.arrow_right_1)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !_ptGridVisible,
                child: Row(
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.only(right: 10.0, top: 20, bottom: 15),
                      child: Text(
                        "Posti suggeriti",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: !_ptGridVisible,
                  child: BlocProvider(
                    create: (_) => _searchLocationBloc,
                    child:
                        BlocListener<SearchLocationBloc, SearchLocationState>(
                      listener: (context, state) {
                        if (state is SearchLocationError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message!),
                            ),
                          );
                        }
                      },
                      child:
                          BlocBuilder<SearchLocationBloc, SearchLocationState>(
                        builder: (context, state) {
                          if (state is SearchLocationInitial ||
                              state is SearchLocationLoading) {
                            return const LoadingIndicator();
                          } else if (state is SearchLocationLoaded) {
                            return PtLocationGrid(
                              locationList: state.searchLocationModel,
                            );
                          } else if (state is SearchLocationError) {
                            return Container(
                              child: Text("error 1"),
                            );
                          } else {
                            return Container(
                              child: Text("error 2"),
                            );
                          }
                        },
                      ),
                    ),
                  ))
            ],
          ),
        )),
      ),
    );
  }
}

class PtLocationGrid extends StatelessWidget {
  const PtLocationGrid({
    Key? key,
    required this.locationList,
  }) : super(key: key);

  final List<Location> locationList;

  List<Widget> getLocationCnt() {
    List<Widget> locCnt = [];

    locationList.forEach((el) => {
          locCnt.add(Container(
            decoration: BoxDecoration(
                color: UIColors.bluelight,
                borderRadius: BorderRadius.circular(20)),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      el.name ?? '',
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      el.name ?? '',
                      overflow: TextOverflow.visible,
                    ),
                  )
                ],
              ),
            ),
          ))
        });

    return locCnt;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MasonryGrid(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          column: 2,
          children: getLocationCnt()),
    );
  }
}

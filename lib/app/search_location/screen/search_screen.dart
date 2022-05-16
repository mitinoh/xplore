import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/app/search_location/bloc/search_location_bloc.dart';
import 'package:xplore/app/search_location/widget/list_card_category_widget.dart';
import 'package:xplore/app/search_location/widget/pt_location_grid_widget.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widget/widget_core.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late bool _ptGridVisible = false;
  final LocationcategoryBloc _locCatBloc = LocationcategoryBloc();
  final SearchHomeBloc _searchHomeBloc = SearchHomeBloc();

  @override
  void initState() {
    if (!_searchHomeBloc.isClosed) {
      _searchHomeBloc.add(const GetSearchLocationList(add: true));
    }
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  filterLocation() {
    _searchHomeBloc.add(GetSearchLocationList(
        searchName: _searchController.text.toString(), add: false));
  }

  void applyFilterName() {
    filterLocation();

    _searchHomeBloc.add(GetSearchLocationList(
        searchName: _searchController.text.toString(), add: false));

    //HomeRepository.skip = 1;
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
                  InkWell(
                      onTap: () => {categoryModal(context)},
                      child: const Icon(Iconsax.setting_4))
                ],
              ),
              const SizedBox(height: 20),
              searchBar(),
              const SizedBox(
                height: 10,
              ),
              suggestedLocation(),
              gridHeader(),
              locationGrid()
            ],
          ),
        )),
      ),
    );
  }

  Visibility suggestedLocation() {
    return Visibility(
      visible: _ptGridVisible,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: UIColors.bluelight,
                ),
                Text(
                  "Roma",
                  style: GoogleFonts.poppins(
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
                Text(
                  "Bologna",
                  style: GoogleFonts.poppins(
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
                Text(
                  "Genova",
                  style: GoogleFonts.poppins(
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
                Text(
                  "Milano",
                  style: GoogleFonts.poppins(
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
                Text(
                  "Barcellona",
                  style: GoogleFonts.poppins(
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
    );
  }

  Visibility gridHeader() {
    return Visibility(
      visible: true,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 20, bottom: 15),
            child: Text(
              "Posti suggeriti",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Row searchBar() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: UIColors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _ptGridVisible = hasFocus;
              });
            },
            child: TextField(
              onSubmitted: (value) {
                applyFilterName();
              },
              controller: _searchController,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "cerca un posto",
                hintStyle:
                    GoogleFonts.poppins(color: UIColors.grey, fontSize: 14),
                border: const OutlineInputBorder(),
                suffixIconColor: UIColors.violet,
                prefixIcon: IconButton(
                  icon: Icon(
                    Iconsax.search_normal,
                    color: UIColors.violet,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    applyFilterName();
                  },
                ),
              ),
              autofocus: false,
            ),
          ),
        ))
      ],
    );
  }

  Visibility locationGrid() {
    return Visibility(
        visible: true,
        child: BlocProvider(
          create: (_) => _searchHomeBloc,
          child: BlocListener<SearchHomeBloc, SearchLocationState>(
            listener: (context, state) {
              if (state is SearchLocationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<SearchHomeBloc, SearchLocationState>(
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
        ));
  }

  Future<void> categoryModal(BuildContext context) {
    return showModalBottomSheet<void>(
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return BlocProvider(
            create: (_) => _locCatBloc,
            child: BlocListener<LocationcategoryBloc, LocationcategoryState>(
              listener: (context, state) {
                if (state is LocationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("error"),
                    ),
                  );
                }
              },
              child: BlocBuilder<LocationcategoryBloc, LocationcategoryState>(
                builder: (context, state) {
                  if (state is LocationcategoryInitial ||
                      state is LocationCategoryLoading) {
                    return const LoadingIndicator();
                  } else if (state is LocationcategoryLoaded) {
                    return BuildListCardCategory(
                      context: context,
                      model: state.locationCategoryModel,
                      homeBloc: _searchHomeBloc,
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
  }
}

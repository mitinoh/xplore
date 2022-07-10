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
import 'package:xplore/core/widgets/widget_core.dart';
import 'package:xplore/model/user_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // final TextEditingController _searchController = TextEditingController();
  //late bool _ptGridVisible = false;
  final LocationCategoryBloc _locCatBloc = LocationCategoryBloc();
  final SearchHomeBloc _searchHomeBloc = SearchHomeBloc();

  String searchText = "";
  //late FocusNode filerFocusNode;

  late var lightDark;
  @override
  void initState() {
    if (!_searchHomeBloc.isClosed) {
      _searchHomeBloc.add(const GetSearchLocationList(add: true));
    }
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();

    //filerFocusNode = FocusNode();
    /*
    filerFocusNode.addListener(() {
      if (!filerFocusNode.hasFocus) {
        setState(() {
          filterLocation(searchText);
        });
      }
    });
    */
  }

  filterLocation(String filter) {
    if (filter.startsWith("@")) {
      _searchHomeBloc.add(GetSearchUsersList(searchName: filter));
    } else {
      _searchHomeBloc
          .add(GetSearchLocationList(searchName: filter, add: false));
    }
  }

/*
  void applyFilterName() {
    filterLocation();

    _searchHomeBloc.add(GetSearchLocationList(
        searchName: _searchController.text.toString(), add: false));

    //HomeRepository.skip = 1;
  }
*/
  @override
  Widget build(BuildContext context) {
    lightDark = Theme.of(context);
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: true,
            elevation: 0,
            centerTitle: true,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            backgroundColor: lightDark.scaffoldBackgroundColor,
            iconTheme: IconThemeData(color: lightDark.primaryColor),
            actionsIconTheme: IconThemeData(color: lightDark.primaryColor),
            leading: GestureDetector(
                onTap: () => {Navigator.pop(context)},
                child: Icon(Iconsax.arrow_left, color: lightDark.primaryColor)),
            leadingWidth: 23,
            title: Text(
              "Cerca",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: lightDark.primaryColor),
            ),
            actions: [
              InkWell(
                  onTap: () => {categoryModal(context, lightDark)},
                  child:
                      Icon(Iconsax.setting_4, color: lightDark.primaryColor)),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                searchBar(lightDark),
                const SizedBox(
                  height: 10,
                ),
                //suggestedLocation(),
                gridHeader(lightDark),
                locationGrid()
              ],
            ),
          ),
        ],
      ),
    )));
  }

/*
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
*/
  Visibility gridHeader(lightDark) {
    return Visibility(
      visible: true,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 20, bottom: 15),
            child: Text(
              "Posti suggeriti",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: lightDark.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Row searchBar(lightDark) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: lightDark.cardColor,
              borderRadius: BorderRadius.circular(20)),
          child: Focus(
            /*onFocusChange: (hasFocus) {
              setState(() {
                _ptGridVisible = hasFocus;
              });
            },*/
            child: TextField(
              //  focusNode: filerFocusNode,
              onSubmitted: (value) {
                filterLocation(value);
              },
              /*
              onChanged: (String value) {
                searchText = value;
                filterLocation(value);
              },*/
              /*
              onChanged: (value) {
                // _searchHomeBloc.add(GetSuggestedNameLocationList(
                //     searchName: _searchController.text.toString()));
                //applyFilterName();
//GetSuggestedNameLocationList
              },*/
              //controller: _searchController,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                  color: lightDark.hoverColor, fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "cerca un posto o un @utente",
                hintStyle: GoogleFonts.poppins(
                    color: lightDark.unselectedWidgetColor, fontSize: 14),
                border: const OutlineInputBorder(),
                suffixIconColor: UIColors.blue,
                prefixIcon: IconButton(
                  icon: Icon(
                    Iconsax.search_normal,
                    color: UIColors.blue,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    //  applyFilterName();
                  },
                ),
              ),
              autofocus: true,
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
                    state is SearchUserLoading) {
                  return const LoadingIndicator();
                } else if (state is SearchLocationLoaded) {
                  return PtLocationGrid(
                    locationList: state.searchLocationModel,
                  );
                } else if (state is SearchUserLoaded) {
                  return userList(state.searchUserModel);
                } else if (state is SearchLocationError) {
                  return const Text("error 1");
                } else {
                  return const LoadingIndicator();
                }
              },
            ),
          ),
        ));
  }

  Future<void> categoryModal(BuildContext context, lightDark) {
    return showModalBottomSheet<void>(
        //useRootNavigator: true,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: lightDark.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return BlocProvider(
            create: (_) => _locCatBloc,
            child: BlocListener<LocationCategoryBloc, LocationcategoryState>(
              listener: (context, state) {
                if (state is LocationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("error"),
                    ),
                  );
                }
              },
              child: BlocBuilder<LocationCategoryBloc, LocationcategoryState>(
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

  Widget userList(List<UserModel> userList) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: userList.length,
      itemBuilder: (BuildContext context, int index) {
        // TODO: da rifare con un metodo che ritorna tutto questo e non uno alla volta

        return Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: lightDark.splashColor,
          ),
          child: Theme(
              data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  unselectedWidgetColor: Colors.grey.withOpacity(0.3)),
              child: Text(userList[index].name ?? '')),
        );
      },
    );
  }
}

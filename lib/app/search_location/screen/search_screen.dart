import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/app/search_location/bloc/search_location_bloc.dart';
import 'package:xplore/app/search_location/widget/list_card_category_widget.dart';
import 'package:xplore/app/search_location/widget/pt_location_grid_widget.dart';
import 'package:xplore/app/user/screen/dashboard.dart';
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
                const SizedBox(height: 0),
                searchBar(lightDark),
                const SizedBox(
                  height: 15,
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
            padding: const EdgeInsets.only(right: 10.0, top: 15, bottom: 15),
            child: Text(
              "Suggerimenti",
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
                suffixIconColor: UIColors.mainColor,
                prefixIcon: IconButton(
                  icon: Icon(
                    Iconsax.search_normal,
                    color: UIColors.mainColor,
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
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => Divider(
        height: 30,
        color: lightDark.primaryColor.withOpacity(0.1),
      ),
      itemCount: userList.length,
      itemBuilder: (BuildContext context, int index) {
        // TODO: da rifare con un metodo che ritorna tutto questo e non uno alla volta

        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => UserScreen(
                          visualOnly: true,
                          user: userList[index],
                        )));
          },
          child: Theme(
              data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  unselectedWidgetColor: Colors.grey.withOpacity(0.3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundColor: UIColors.bluelight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const LoadingIndicator(),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(Iconsax.gallery_slash,
                                    size: 30, color: UIColors.lightRed),
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userList[index].name ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: lightDark.primaryColor),
                            ),
                            Text(
                              "LV. 1",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: UIColors.lightblue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(Iconsax.arrow_right_1)
                ],
              )),
        );
      },
    );
  }
}

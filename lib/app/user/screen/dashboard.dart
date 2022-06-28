import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/auth/screen/sign_in.dart';
import 'package:xplore/app/user/bloc_saved_location/saved_location_bloc.dart';
import 'package:xplore/app/user/bloc_uploaded_location/uploaded_location_bloc.dart';
import 'package:xplore/app/user/screen/edit_screen.dart';
import 'package:xplore/app/user/user_location_bloc/user_location_bloc.dart';
import 'package:xplore/app/user/widgets/image_tile.dart';
import 'package:xplore/app/user/widgets/settings.dart';
import 'package:xplore/app/user/widgets/user_information.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/detail_location_modal.dart';
import 'package:xplore/core/widgets/widget_core.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  static refreshLocations() {
    _UserScreenState.refreshLocations();
  }

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  //final UserLocationBloc _savedLocationBloc = UserLocationBloc();
  static SavedLocationBloc _savedLocationBloc = SavedLocationBloc();
  static UploadedLocationBloc _uploadedLocationBloc = UploadedLocationBloc();

  static refreshLocations() {
    _savedLocationBloc..add(const SavedLocationInitUserListEvent());
    _uploadedLocationBloc..add(const UploadedLocationInitUserListEvent());
  }

  @override
  void initState() {
    //_savedLocationBloc.add(GetUserSavedLocationList());
    //_savedLocationBloc.add(GetUserUploadedLocationList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    // Getting the user from the FirebaseAuth Instance
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);

    final List<dynamic> tabs = <dynamic>[
      {"name": 'Posti piaciuti', "event": const GetUserSavedLocationList([])},
      {"name": 'Caricati', "event": const GetUserUploadedLocationList()}
    ]; // Visitati

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: Colors.white,
      backgroundColor: Colors.blue,
      strokeWidth: 4.0,
      onRefresh: () {
        // Replace this delay with the code to be executed during refresh
        // and return a Future when code finishs execution.
        //  context.read<SavedLocationBloc>().add(SavedLocationInitUserListEvent());

        //_savedLocationBloc..add(const SavedLocationInitUserListEvent());
        //_uploadedLocationBloc..add(const UploadedLocationInitUserListEvent());

        return Future<void>.delayed(const Duration(seconds: 3));
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false,
            );
          }
        },
        child: DefaultTabController(
          length: tabs.length, // This is the number of tabs.
          child: Scaffold(
            //backgroundColor: const Color(0xffF3F7FA),
            body: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
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
                      actionsIconTheme:
                          IconThemeData(color: lightDark.primaryColor),
                      leading: GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()),
                                )
                              },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Icon(Iconsax.magicpen),
                          )),
                      leadingWidth: 44,
                      title: Text(
                        "Il tuo profilo",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: lightDark.primaryColor),
                      ),
                      actions: [
                        InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useRootNavigator: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return const SettingsBottomSheet();
                                  });
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Icon(Iconsax.setting_2),
                            )),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Column(
                          children: [
                            //const SizedBox(height: 20),
                            //const UserHeaderNavigation(),
                            const SizedBox(height: 10),
                            const UserInformation(),
                            const SizedBox(height: 20.5),
                            TabBar(
                              // These are the widgets to put in each tab in the tab bar.
                              indicatorColor: lightDark.primaryColor,
                              indicatorWeight: 1,
                              labelColor: lightDark.primaryColor,
                              unselectedLabelColor:
                                  lightDark.primaryColor.withOpacity(0.2),
                              tabs: tabs
                                  .map((dynamic obj) => Tab(
                                        iconMargin: const EdgeInsets.all(0),
                                        child: Text(
                                          obj["name"],
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: Padding(
                    padding: const EdgeInsets.only(left: 17.5, right: 17.5),
                    child: SafeArea(
                        top: false,
                        bottom: false,
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (_) => _savedLocationBloc
                                ..add(const SavedLocationInitUserListEvent()),
                            ),
                            BlocProvider(
                              create: (_) => _uploadedLocationBloc
                                ..add(
                                    const UploadedLocationInitUserListEvent()),
                            )
                          ],
                          child: TabBarView(children: [
                            BlocBuilder<SavedLocationBloc, SavedLocationState>(
                              builder: (context, state) {
                                if (state is SavedLocationLoadedState) {
                                  return (state.savedLocationList.length > 0)
                                      ? CustomScrollView(
                                          // key: PageStorageKey<String>(obj["name"]),
                                          slivers: [
                                            SliverGrid(
                                              gridDelegate:
                                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200.0,
                                                mainAxisSpacing: 0,
                                                crossAxisSpacing: 0,
                                                childAspectRatio: 1.0,
                                              ),
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                                (BuildContext context,
                                                    int index) {
                                                  print(state
                                                          .savedLocationList[
                                                              index]
                                                          .saved ==
                                                      true);
                                                  // commento
                                                  return state
                                                              .savedLocationList[
                                                                  index]
                                                              .saved ==
                                                          true
                                                      ? InkWell(
                                                          onTap: () {
                                                            DetailLocationModal(
                                                              loc: state
                                                                      .savedLocationList[
                                                                  index],
                                                              fromLikedSection:
                                                                  true,
                                                              callback: () {
                                                                setState(() {
                                                                  state
                                                                      .savedLocationList[
                                                                          index]
                                                                      .saved = state
                                                                              .savedLocationList[index]
                                                                              .saved !=
                                                                          true
                                                                      ? false
                                                                      : true;
                                                                });
                                                              },
                                                            ).show(context);
                                                            /*
                                                        BlocProvider.of<
                                                                UserLocationBloc>(
                                                            context)
                                                          ..add(GetUserSavedLocationList(
                                                              state
                                                                  .savedLocationModel));
    
                                                                  */
                                                          },
                                                          child: ImageTile(
                                                              location: state
                                                                      .savedLocationList[
                                                                  index]),
                                                        )
                                                      : const SizedBox();
                                                },
                                                childCount: state
                                                    .savedLocationList
                                                    .map((e) => e.saved)
                                                    .length,
                                              ),
                                            )
                                          ],
                                        )
                                      : Center(
                                          child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Iconsax.coffee,
                                                color: lightDark.primaryColor,
                                              ),
                                            ),
                                            Text("no data found",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: lightDark
                                                        .primaryColor)),
                                          ],
                                        ));
                                } else {
                                  return const LoadingIndicator();
                                }
                              },
                            ),
                            BlocBuilder<UploadedLocationBloc,
                                UploadedLocationState>(
                              builder: (context, state) {
                                if (state is UploadedLocationLoadedState) {
                                  return (state.uploadedLocationList.length > 0)
                                      ? CustomScrollView(
                                          // key: PageStorageKey<String>(obj["name"]),
                                          slivers: [
                                            SliverGrid(
                                              gridDelegate:
                                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200.0,
                                                mainAxisSpacing: 0,
                                                crossAxisSpacing: 0,
                                                childAspectRatio: 1.0,
                                              ),
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                                (BuildContext context,
                                                    int index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      DetailLocationModal(
                                                              loc: state
                                                                      .uploadedLocationList[
                                                                  index])
                                                          .show(context);
                                                      /*
                                                        BlocProvider.of<
                                                                UserLocationBloc>(
                                                            context)
                                                          ..add(GetUserSavedLocationList(
                                                              state
                                                                  .savedLocationModel));
    
                                                                  */
                                                    },
                                                    child: ImageTile(
                                                        location: state
                                                                .uploadedLocationList[
                                                            index]),
                                                  );
                                                },
                                                childCount: state
                                                    .uploadedLocationList
                                                    .length,
                                              ),
                                            )
                                          ],
                                        )
                                      : Center(
                                          child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Iconsax.coffee,
                                                color: lightDark.primaryColor,
                                              ),
                                            ),
                                            Text("no data found",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: lightDark
                                                        .primaryColor)),
                                          ],
                                        ));
                                } else {
                                  return const LoadingIndicator();
                                }
                              },
                            ),
                          ]),
                        ))

                    /*
                   TabBarView(
                      // These are the contents of the tab views, below the tabs.
                      children: /*tabs.map((
                      dynamic obj,
                    ) { return*/
                          [
                     ] //}).toList(),
                      ),
                ),*/
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

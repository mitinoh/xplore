import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/auth/screen/sign_in.dart';
import 'package:xplore/app/user/bloc_saved_location/saved_location_bloc.dart';
import 'package:xplore/app/user/bloc_uploaded_location/uploaded_location_bloc.dart';
import 'package:xplore/app/user/user_location_bloc/user_location_bloc.dart';
import 'package:xplore/app/user/widgets/header_navigation.dart';
import 'package:xplore/app/user/widgets/image_tile.dart';
import 'package:xplore/app/user/widgets/user_information.dart';
import 'package:xplore/core/widgets/widget_core.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  //final UserLocationBloc _savedLocationBloc = UserLocationBloc();

  @override
  void initState() {
    //_savedLocationBloc.add(GetUserSavedLocationList());
    //_savedLocationBloc.add(GetUserUploadedLocationList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    var mediaQuery = MediaQuery.of(context);

    final List<dynamic> tabs = <dynamic>[
      {"name": 'Piaciuti', "event": GetUserSavedLocationList([])},
      {"name": 'Caricati', "event": GetUserUploadedLocationList()}
    ]; // Visitati

    event(dynamic obj) {
      log(obj["event"].toString());
      //_savedLocationBloc.add(obj["event"]);
    }

    return BlocListener<AuthBloc, AuthState>(
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
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const UserHeaderNavigation(),
                            const SizedBox(height: 20),
                            const UserInformation(),
                            const SizedBox(height: 30),
                            TabBar(
                              // These are the widgets to put in each tab in the tab bar.
                              indicatorColor: Colors.black,
                              indicatorWeight: 1,
                              labelColor: Colors.black,
                              unselectedLabelColor:
                                  Colors.black.withOpacity(0.2),
                              tabs: tabs
                                  .map((dynamic obj) => Tab(
                                        iconMargin: EdgeInsets.all(0),
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
                              create: (_) => SavedLocationBloc()
                                ..add(const SavedLocationInitUserListEvent()),
                            ),
                            BlocProvider(
                              create: (_) => UploadedLocationBloc()
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
                                                  log("---------");
                                                  log(state.props.toString());
                                                  return InkWell(
                                                    onTap: () {
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
                                                  );
                                                  return ImageTile(
                                                      location: state
                                                              .savedLocationList[
                                                          index]);
                                                },
                                                childCount: state
                                                    .savedLocationList.length,
                                              ),
                                            )
                                          ],
                                        )
                                      : Text("no data found");
                                } else {
                                  return LoadingIndicator();
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
                                                  log("---------");
                                                  log(state.props.toString());
                                                  return InkWell(
                                                    onTap: () {
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
                                      : Text("no data found");
                                } else {
                                  return LoadingIndicator();
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
        ));
  }
}

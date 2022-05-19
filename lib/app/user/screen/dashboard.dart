import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/auth/screen/sign_in.dart';
import 'package:xplore/app/user/bloc/saved_location_bloc.dart';
import 'package:xplore/app/user/widgets/header_navigation.dart';
import 'package:xplore/app/user/widgets/image_tile.dart';
import 'package:xplore/app/user/widgets/user_information.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widget/snackbar_message.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final SavedLocationBloc _savedLocationBloc = SavedLocationBloc();

  @override
  void initState() {
    _savedLocationBloc.add(GetSavedLocationList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    var mediaQuery = MediaQuery.of(context);

    final List<String> tabs = <String>['Luoghi piaciuti', 'Luoghi visitati'];
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
                            unselectedLabelColor: Colors.black.withOpacity(0.2),
                            tabs: tabs
                                .map((String name) => Tab(
                                      child: Text(
                                        name,
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
                child: TabBarView(
                  // These are the contents of the tab views, below the tabs.
                  children: tabs.map((String name) {
                    return SafeArea(
                      top: false,
                      bottom: false,
                      child: Builder(
                        builder: (BuildContext context) {
                          return CustomScrollView(
                            key: PageStorageKey<String>(name),
                            slivers: <Widget>[
                              BlocProvider(
                                create: (_) => _savedLocationBloc,
                                child: BlocListener<SavedLocationBloc,
                                    SavedLocationState>(
                                  listener: (context, state) {
                                    if (state is LocationError) {
                                      SnackBarMessage.show(
                                          context, state.message ?? '');
                                    }
                                  },
                                  child: BlocBuilder<SavedLocationBloc,
                                      SavedLocationState>(
                                    builder: (context, state) {
                                      if (state is SavedLocationLoaded) {
                                        return SliverGrid(
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 200.0,
                                            mainAxisSpacing: 5.0,
                                            crossAxisSpacing: 5.0,
                                            childAspectRatio: 1.0,
                                          ),
                                          delegate: SliverChildBuilderDelegate(
                                            (BuildContext context, int index) {
                                              return ImageTile(
                                                  location:
                                                      state.savedLocationModel[
                                                          index]);
                                            },
                                            childCount:
                                                state.savedLocationModel.length,
                                          ),
                                        );
                                        //return getCards(state.homeModel);
                                      } else {
                                        return SliverGrid(
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 200.0,
                                            mainAxisSpacing: 5.0,
                                            crossAxisSpacing: 5.0,
                                            childAspectRatio: 1.0,
                                          ),
                                          delegate: SliverChildBuilderDelegate(
                                            (BuildContext context, int index) {
                                              return Container();
                                            },
                                            childCount: 0,
                                          ),
                                        );
                                        ;
                                      }
                                    },
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

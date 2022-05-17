import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/auth/screen/sign_in.dart';
import 'package:xplore/app/user/widgets/header_navigation.dart';
import 'package:xplore/app/user/widgets/image_tile.dart';
import 'package:xplore/app/user/widgets/user_information.dart';
import 'package:xplore/core/UIColors.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    var mediaQuery = MediaQuery.of(context);

    final List<String> tabs = <String>['Piaciuti', 'Visitati'];
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
          body: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const UserHeaderNavigation(),
                          const SizedBox(height: 20),
                          const UserInformation(),
                          const SizedBox(height: 20),
                          TabBar(
                            // These are the widgets to put in each tab in the tab bar.
                            indicatorColor: UIColors.blue,
                            indicatorWeight: 3,
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
                  ];
                },
                body: TabBarView(
                  // These are the contents of the tab views, below the tabs.
                  children: tabs.map((String name) {
                    return SafeArea(
                      top: false,
                      bottom: false,
                      child: Builder(
                        // This Builder is needed to provide a BuildContext that is
                        // "inside" the NestedScrollView, so that
                        // sliverOverlapAbsorberHandleFor() can find the
                        // NestedScrollView.
                        builder: (BuildContext context) {
                          return CustomScrollView(
                            // The "controller" and "primary" members should be left
                            // unset, so that the NestedScrollView can control this
                            // inner scroll view.
                            // If the "controller" property is set, then this scroll
                            // view will not be associated with the NestedScrollView.
                            // The PageStorageKey should be unique to this ScrollView;
                            // it allows the list to remember its scroll position when
                            // the tab view is not on the screen.
                            key: PageStorageKey<String>(name),
                            slivers: <Widget>[
                              SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200.0,
                                  mainAxisSpacing: 5.0,
                                  crossAxisSpacing: 5.0,
                                  childAspectRatio: 1.0,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return const ImageTile();
                                  },
                                  childCount: 5,
                                ),
                              ),
                              /*SliverPadding(
                                padding: const EdgeInsets.all(8.0),
                                // In this example, the inner scroll view has
                                // fixed-height list items, hence the use of
                                // SliverFixedExtentList. However, one could use any
                                // sliver widget here, e.g. SliverList or SliverGrid.
                                sliver: SliverFixedExtentList(
                                  // The items in this example are fixed to 48 pixels
                                  // high. This matches the Material Design spec for
                                  // ListTile widgets.
                                  itemExtent: 250.0,
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      // This builder is called for each child.
                                      // In this example, we just number each list item.
                                      return const ImageTile();
                                    },
                                    // The childCount of the SliverChildBuilderDelegate
                                    // specifies how many children this inner list
                                    // has. In this example, each tab has a list of
                                    // exactly 30 items, but this is arbitrary.
                                    childCount: 30,
                                  ),
                                ),
                              ),*/
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

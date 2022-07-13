import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/auth/screen/sign_in.dart';
import 'package:xplore/app/user/bloc_follower_count/follower_count_bloc.dart';
import 'package:xplore/app/user/bloc_saved_location/saved_location_bloc.dart';
import 'package:xplore/app/user/bloc_uploaded_location/uploaded_location_bloc.dart';
import 'package:xplore/app/user/screen/edit_screen.dart';
import 'package:xplore/app/user/user_bloc/user_bloc_bloc.dart';
import 'package:xplore/app/user/user_location_bloc/user_location_bloc.dart';
import 'package:xplore/app/user/widgets/counter_follower_and_trips.dart';
import 'package:xplore/app/user/widgets/empty_data.dart';
import 'package:xplore/app/user/widgets/follower.dart';
import 'package:xplore/app/user/widgets/image_tile.dart';
import 'package:xplore/app/user/widgets/settings.dart';
import 'package:xplore/app/user/widgets/user_information.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/detail_location_modal.dart';
import 'package:xplore/core/widgets/widget_core.dart';

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
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    // Getting the user from the FirebaseAuth Instance
    //var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);

    final List<dynamic> tabs = <dynamic>[
      {
        "name": '❤️ Posti piaciuti',
        "event": const GetUserSavedLocationList([])
      },
      {"name": '📤 Caricati', "event": const GetUserUploadedLocationList()}
    ]; // Visitati

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
      child: BlocProvider(
        create: (context) => UserBlocBloc(),
        child: BlocBuilder<UserBlocBloc, UserBlocState>(
          builder: (context, state) {
            return DefaultTabController(
                length: tabs.length, // This is the number of tabs.
                child: Scaffold(
                  //backgroundColor: const Color(0xffF3F7FA),
                  body: SafeArea(
                    child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext ctx, bool innerBoxIsScrolled) {
                        // These are the slivers that show up in the "outer" scroll view.
                        return <Widget>[
                          getSliverAppBar(lightDark, context),
                          getSliverToBoxAdapter(
                              context: context,
                              lightDark: lightDark,
                              tabs: tabs),
                        ];
                      },
                      body: Padding(
                          padding:
                              const EdgeInsets.only(left: 17.5, right: 17.5),
                          child: SafeArea(
                            top: false,
                            bottom: false,
                            child: getTabBarView(lightDark),
                          )),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget getTabBarView(ThemeData lightDark) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              SavedLocationBloc()..add(const SavedLocationInitUserListEvent()),
        ),
        BlocProvider(
          create: (_) => UploadedLocationBloc()
            ..add(const UploadedLocationInitUserListEvent()),
        )
      ],
      child: TabBarView(children: [
        BlocBuilder<SavedLocationBloc, SavedLocationState>(
          builder: (context, state) {
            if (state is SavedLocationLoadedState) {
              return RefreshIndicator(
                color: UIColors.white,
                backgroundColor: UIColors.blue,
                edgeOffset: 0,
                onRefresh: () {
                  context
                      .read<SavedLocationBloc>()
                      .add(SavedLocationInitUserListEvent());
                  return Future<void>.delayed(const Duration(seconds: 1));
                },
                child: (state.savedLocationList.length > 0)
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
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                // commento
                                return state.savedLocationList[index].saved ==
                                        true
                                    ? InkWell(
                                        onTap: () {
                                          DetailLocationModal(
                                            loc: state.savedLocationList[index],
                                            fromLikedSection: true,
                                            callback: () {
                                              setState(() {
                                                state.savedLocationList[index]
                                                    .saved = state
                                                            .savedLocationList[
                                                                index]
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
                                            location:
                                                state.savedLocationList[index]),
                                      )
                                    : const SizedBox();
                              },
                              childCount: state.savedLocationList
                                  .map((e) => e.saved)
                                  .length,
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: ListView(
                          children: const [EmptyData()],
                        ),
                      ),
              );
            } else {
              return const LoadingIndicator();
            }
          },
        ),
        BlocBuilder<UploadedLocationBloc, UploadedLocationState>(
          builder: (context, state) {
            if (state is UploadedLocationLoadedState) {
              return RefreshIndicator(
                color: UIColors.white,
                backgroundColor: UIColors.blue,
                edgeOffset: 0,
                onRefresh: () {
                  context
                      .read<UploadedLocationBloc>()
                      .add(UploadedLocationInitUserListEvent());

                  return Future<void>.delayed(const Duration(seconds: 1));
                },
                child: (state.uploadedLocationList.length > 0)
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
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    DetailLocationModal(
                                            loc: state
                                                .uploadedLocationList[index])
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
                                      location:
                                          state.uploadedLocationList[index]),
                                );
                              },
                              childCount: state.uploadedLocationList.length,
                            ),
                          )
                        ],
                      )
                    : ListView(
                        children: const [EmptyData()],
                      ),
              );
            } else {
              return const LoadingIndicator();
            }
          },
        ),
      ]),
    );
  }

  SliverAppBar getSliverAppBar(ThemeData lightDark, BuildContext context) {
    return SliverAppBar(
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
          onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctz) => EditProfile(
                            context: context,
                          )),
                )
              },
          child: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(Iconsax.magicpen),
          )),
      leadingWidth: 44,
      title: Text(
        "artenis_molla".toLowerCase(),
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
                  backgroundColor: lightDark.backgroundColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  builder: (context) {
                    return const SettingsBottomSheet();
                  });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Iconsax.setting_2),
            )),
      ],
    );
  }
}

class getSliverToBoxAdapter extends StatelessWidget {
  const getSliverToBoxAdapter(
      {Key? key,
      required this.lightDark,
      required this.tabs,
      required this.context})
      : super(key: key);

  final ThemeData lightDark;
  final List tabs;
  final BuildContext context;

  @override
  Widget build(BuildContext ctx) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: [
            //const SizedBox(height: 20),
            //const UserHeaderNavigation(),
            //const SizedBox(height: 10),

            UserInformation(context: context),
            //const SizedBox(height: 20),
            //const CounterFollowerAndTrips(),
            const SizedBox(height: 10),
            TabBar(
              isScrollable: false,
              enableFeedback: true,
              automaticIndicatorColorAdjustment: true,
              // These are the widgets to put in each tab in the tab bar.
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: UIColors.platinium),
              indicatorWeight: 0,
              labelColor: Colors.black,
              unselectedLabelColor: lightDark.primaryColor.withOpacity(0.3),
              tabs: tabs
                  .map((dynamic obj) => Tab(
                        iconMargin: const EdgeInsets.all(0),
                        child: Text(
                          obj["name"],
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

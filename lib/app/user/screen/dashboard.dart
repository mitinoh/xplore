import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/auth/screen/sign_in.dart';
import 'package:xplore/app/location/screen/new_location_screen.dart';
import 'package:xplore/app/user/screen/edit_screen.dart';
import 'package:xplore/app/user/widgets/settings.dart';

import 'package:xplore/core/UIColors.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    final user = FirebaseAuth.instance.currentUser!;
    var mediaQuery = MediaQuery.of(context);
    final List<String> tabs = <String>['Tab 1', 'Tab 2'];
    final List<String> _tabs = <String>['Piaciuti', 'Salvati', 'Visitati'];
    return Scaffold(
      backgroundColor: const Color(0xffF3F7FA),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignIn()),
              (route) => false,
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()),
                                );
                              },
                              child: const Icon(Iconsax.edit)),
                          InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return const SettingsBottomSheet();
                                    });
                              },
                              child: Icon(Iconsax.more))
                        ],
                      ),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: UIColors.blue,
                        child: const Icon(
                          Iconsax.user,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "mite.g",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "29",
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              Text(
                                "post visitati",
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "2",
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              Text(
                                "in programma",
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: UIColors.green,
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              // border: Border.all(width: 1, color: UIColors.grey)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Iconsax.cup, color: Colors.white),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Trophy room lv.4".toUpperCase(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TabBar(
                        controller: _tabController,
                        indicatorColor: UIColors.blue,
                        indicatorWeight: 3,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black.withOpacity(0.2),
                        tabs: [
                          Tab(
                              //iconMargin: EdgeInsets.zero,
                              child: Text(
                            "Piaciuti",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                          Tab(
                              child: Text(
                            "Salvati",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                          Tab(
                              child: Text(
                            "Visitati",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: UIColors.bluelight,
                                borderRadius: BorderRadius.circular(20)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text("luogo",
                                        overflow: TextOverflow.visible,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w300)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Icon(Iconsax.note_favorite),
                          const Icon(Icons.done),
                        ],
                      );
                    },
                    childCount: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

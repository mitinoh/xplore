import 'package:flutter/material.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/presentation/screen/user/widget/wg_user_information.dart';

class SliverBoxAdapterWidget extends StatelessWidget {
  SliverBoxAdapterWidget(
      {Key? key, required this.tabs, required this.user, this.visualOnly = false})
      : super(key: key);

  final List tabs;
  final UserModel user;
  final bool visualOnly;

  late MediaQueryData mediaQueryX;
  late ThemeData themex;

  @override
  Widget build(BuildContext context) {
    mediaQueryX = MediaQuery.of(context);
    themex = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: [
            UserInformationWidget(
              visualOnly: visualOnly,
              user: user,
            ),
            const SizedBox(height: 20),
            //const CounterFollowerAndTrips(),
            const SizedBox(height: 10),
            _tabBar(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  TabBar _tabBar() {
    return TabBar(
      isScrollable: false,
      enableFeedback: true,
      automaticIndicatorColorAdjustment: true,
      // These are the widgets to put in each tab in the tab bar.
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: themex.focusColor),
      indicatorWeight: 0,
      labelColor: themex.canvasColor,
      unselectedLabelColor: themex.primaryColor.withOpacity(0.3),
      tabs: tabs
          .map((dynamic obj) => Tab(
                iconMargin: const EdgeInsets.all(0),
                child: Text(
                  obj["name"],
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ))
          .toList(),
    );
  }
}

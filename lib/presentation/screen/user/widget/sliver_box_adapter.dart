import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SliverBoxAdapterWidget extends StatelessWidget {
  SliverBoxAdapterWidget({Key? key,    required this.tabs,
    this.user}) : super(key: key);

  final List tabs;
  final UserModel? user;
  late ThemeData _lightDark;
  
  @override
  Widget build(BuildContext context) {
     _lightDark = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: [
            Text("user information"),
            /*UserInformation(
              context: context,
              user: user,
              visualOnly: visualOnly,
            ),*/
            //const SizedBox(height: 20),
            //const CounterFollowerAndTrips(),
            const SizedBox(height: 10),
            TabBar(
              isScrollable: false,
              enableFeedback: true,
              automaticIndicatorColorAdjustment: true,
              // These are the widgets to put in each tab in the tab bar.
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.pink),
              indicatorWeight: 0,
              labelColor: Colors.black,
              unselectedLabelColor: _lightDark.primaryColor.withOpacity(0.3),
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
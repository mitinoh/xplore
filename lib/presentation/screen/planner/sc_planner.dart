import 'package:flutter/material.dart';
import 'package:xplore/presentation/common_widgets/header_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/presentation/screen/planner/bloc_current_trip/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc_future_trip/bloc.dart';
import 'package:xplore/presentation/screen/planner/widget/wg_current_planned_trip.dart';
import 'package:xplore/presentation/screen/planner/widget/wg_future_planned_trip.dart';
import 'package:xplore/presentation/screen/planner/sc_plan_new_trip.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({Key? key}) : super(key: key);

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  late MediaQueryData mediaQueryX = MediaQuery.of(context);
  late ThemeData themex = Theme.of(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RefreshIndicator(
            color: themex.indicatorColor,
            backgroundColor: themex.primaryColor,
            edgeOffset: 0,
            onRefresh: () {
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            child: ListView(children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  _headerTitle(),
                  const SizedBox(height: 20),
                  _headerDesc(),
                  const SizedBox(height: 20),
                  _locationImage(),
                  //topMenuPlanner(),
                  //headerPlanner(),
                  const SizedBox(height: 20),
                  _currentPlannedTrip(),
                  const SizedBox(height: 20),
                  _futurePlannedTrip(),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _headerTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [HeaderName(message: "Your planner ", questionMark: false)],
    );
  }

  Widget _headerDesc() {
    return Row(
      children: [
        Expanded(
          child: Text(
              "Are you about to leave but you don't have a clear idea of ​​what to visit? Do you want to know what to see in a dream weekend? We can help you organize your next trip.🛫",
              overflow: TextOverflow.visible,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: themex.disabledColor)),
        )
      ],
    );
  }

  Widget _locationImage() {
    return InkWell(
      onTap: () {
        _planNewTrip();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: themex.cardColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15),
              child: Icon(
                Iconsax.add,
                color: themex.primaryColor,
              ),
            ),
            Text(
              "Let's embark on a new adventure",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 14, color: themex.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _currentPlannedTrip() {
    return Column(
      children: [
        Text("On going trips",
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w300, color: themex.indicatorColor)),
        Divider(),
        CurrentPlannedTripList(),
      ],
    );
  }

  Widget _futurePlannedTrip() {
    return Column(
      children: [
        Text("Future trips",
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w300, color: themex.indicatorColor)),
        Divider(),
        FuturePlannedTripList(),
      ],
    );
  }

  void _planNewTrip() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => PlanNewTripScreen(
                callback: () {
                  BlocProvider.of<FuturePlannerBloc>(context).add(GetFuturePlannedTrip());
                  BlocProvider.of<CurrentPlannerBloc>(context)
                      .add(GetCurrentPlannedTrip());
                },
              )),
    );
  }

  // void _onRefresh() async {
  //   BlocProvider.of<CurrentPlannerBloc>(context)..add(GetCurrentPlannedTrip());
  // }
}

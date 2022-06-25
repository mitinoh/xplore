import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/app/plantrip/screen/plan_new_trip_screen.dart';
import 'package:xplore/app/plantrip/widget/current_planned_trip_widget.dart';
import 'package:xplore/app/plantrip/widget/planned_trip_widget.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/header_name.dart';

class PlanTripScreen extends StatefulWidget {
  const PlanTripScreen({Key? key}) : super(key: key);

  @override
  State<PlanTripScreen> createState() => _PlanTripScreenState();
}

class _PlanTripScreenState extends State<PlanTripScreen> {
  final PlantripBloc _planTripBloc = PlantripBloc();
  @override
  void initState() {
    super.initState();
    _planTripBloc.add(const GetPlannedTrip());
  }

  @override
  Widget build(BuildContext ctx) {
    var lightDark = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                headerTitle(),
                const SizedBox(height: 20),
                headerDesc(),
                const SizedBox(height: 20),
                locationImage(lightDark),
                //topMenuPlanner(),
                //headerPlanner(),
                const SizedBox(height: 20),
                CurrentPlannedTripList(
                  planTripBloc: _planTripBloc,
                ),
                const SizedBox(height: 20),
                PlannedTripList(
                  planTripBloc: _planTripBloc,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row headerTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [HeaderName(message: "Il tuo planner ", questionMark: false)],
    );
  }

  Row headerDesc() {
    return Row(
      children: [
        Expanded(
          child: Text(
              "lorem ipsum is simply dummy text of the printing and typesetting industry. lorem ipsum is simply dummy.",
              overflow: TextOverflow.visible,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey)),
        )
      ],
    );
  }

  InkWell locationImage(lightDark) {
    return InkWell(
      onTap: () {
        planNewTrip();
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: lightDark.cardColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15),
              child: Icon(
                Iconsax.add,
                color: UIColors.blue,
              ),
            ),
            Text(
              "Crea una nuova vacanza",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: lightDark.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  void planNewTrip() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => PlanNewTrip(
                callback: () {
                  _planTripBloc.add(GetPlannedTrip());
                },
              )),
    );
  }
}

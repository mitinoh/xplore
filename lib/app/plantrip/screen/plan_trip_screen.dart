import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/app/plantrip/screen/plan_new_trip_screen.dart';
import 'package:xplore/app/plantrip/widget/current_planned_trip_widget.dart';
import 'package:xplore/app/plantrip/widget/planned_trip_widget.dart';
import 'package:xplore/core/UIColors.dart';

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
  Widget build(BuildContext context) {
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
                locationImage(),
                //topMenuPlanner(),
                //headerPlanner(),
                const SizedBox(height: 20),
                CurrentPlannedTripList(
                  planTripBloc: _planTripBloc,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "lorem ipsum is simply dummy text of the printing and typesetting industry. Versione app 1.0.1",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    )
                  ],
                ),
                const SizedBox(height: 30),
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
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'Il tuo planner ',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: 'Mite',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: UIColors.blue)),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
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

  InkWell locationImage() {
    return InkWell(
      onTap: () {
        planNewTrip();
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: UIColors.grey.withOpacity(0.3),
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
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  void planNewTrip() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PlanNewTrip()),
    );
  }
}

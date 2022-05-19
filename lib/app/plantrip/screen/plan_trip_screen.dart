import 'package:flutter/material.dart';
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
                topMenuPlanner(),
                headerPlanner(),
                const SizedBox(height: 10),
                CurrentPlannedTripList(
                  planTripBloc: _planTripBloc,
                ),
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

  Padding headerPlanner() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Planner area",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Row topMenuPlanner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(onTap: () => {planNewTrip()}, child: const Icon(Iconsax.add))
      ],
    );
  }


  void planNewTrip() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PlanNewTrip()),
    );
  }
}

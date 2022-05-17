import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/app/plantrip/screen/plan_new_trip_screen.dart';
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
    _planTripBloc.add(GetPlannedTrip());
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
                currentTripCard(),
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

  Container currentTripCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: UIColors.yellow),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          CircleAvatar(
            radius: 50,
            backgroundColor: UIColors.orange,
            foregroundColor: UIColors.violet,
            child: const Icon(
              Iconsax.play_circle,
              size: 60,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          currentTripInfo(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Container currentTripInfo() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          continueTrip(),
          const SizedBox(height: 20),
          progressIndicator()
        ],
      ),
    );
  }

  Row continueTrip() {
    return Row(
      children: const [
        Expanded(
          child: Text("Continue your trip",
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
        ),
      ],
    );
  }

  Row progressIndicator() {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: 0.6,
            valueColor: AlwaysStoppedAnimation<Color>(UIColors.violet),
            backgroundColor: UIColors.violet.withOpacity(0.2),
            semanticsLabel: 'Linear progress indicator',
          ),
        ),
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

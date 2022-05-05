import 'package:flutter/material.dart';
import 'package:xplore/app/plantrip/widget/plan_new_trip_widget.dart';

class PlanNewTrip extends StatefulWidget {
  const PlanNewTrip({Key? key}) : super(key: key);

  @override
  State<PlanNewTrip> createState() => _PlanNewTripState();
}

class _PlanNewTripState extends State<PlanNewTrip> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: const Color(0xffF3F7FA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: NetTripQuestion(),
        ),
      ),
    );
  }
}

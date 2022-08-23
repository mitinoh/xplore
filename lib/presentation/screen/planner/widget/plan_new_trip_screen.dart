import 'package:flutter/material.dart';
import 'package:xplore/presentation/screen/planner/widget/plan_new_trip_widget.dart';
class PlanNewTrip extends StatefulWidget {
  const PlanNewTrip({Key? key, required this.callback}) : super(key: key);
  final VoidCallback? callback;
  @override
  State<PlanNewTrip> createState() => _PlanNewTripState();
}

class _PlanNewTripState extends State<PlanNewTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: NetTripQuestion(
            callback: () {
              widget.callback!();
            },
          ),
        ),
      ),
    );
  }
}

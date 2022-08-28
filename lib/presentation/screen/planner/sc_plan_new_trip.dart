import 'package:flutter/material.dart';
import 'package:xplore/presentation/screen/planner/widget/wg_plan_new_trip.dart';
class PlanNewTripScreen extends StatefulWidget {
  const PlanNewTripScreen({Key? key, required this.callback}) : super(key: key);
  final VoidCallback? callback;
  @override
  State<PlanNewTripScreen> createState() => _PlanNewTripState();
}

class _PlanNewTripState extends State<PlanNewTripScreen> {
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

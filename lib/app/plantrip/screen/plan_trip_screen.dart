import 'package:flutter/material.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/app/plantrip/screen/plan_new_trip_screen.dart';
import 'package:xplore/app/plantrip/widget/planned_trip_widget.dart';

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
    _planTripBloc.add(GetPlannedTrip(body: ''));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          PlannedTripList(
            planTripBloc: _planTripBloc,
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlanNewTrip()),
                );
              },
              child: Text("plan new"),
            ),
          ),
        ],
      ),
    );
  }
}

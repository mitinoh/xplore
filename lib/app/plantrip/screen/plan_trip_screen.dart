import 'package:flutter/material.dart';
import 'package:xplore/app/plantrip/screen/plan_new_trip_screen.dart';

class PlanTripScreen extends StatefulWidget {
  const PlanTripScreen({ Key? key }) : super(key: key);

  @override
  State<PlanTripScreen> createState() => _PlanTripScreenState();
}

class _PlanTripScreenState extends State<PlanTripScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: TextButton(onPressed: () {

            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const PlanNewTrip()),
  );
          }, child: Text("plan new"),),
      ),
    );
  }
}
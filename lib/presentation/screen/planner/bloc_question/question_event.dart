import 'package:flutter/material.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/planner_model.dart';

@immutable
abstract class PlannerQuestionEvent {
  const PlannerQuestionEvent();
}


class PlannerInitQuestion extends PlannerQuestionEvent {
}

class PlannerChangeQuestion extends PlannerQuestionEvent {
  final bool increment;
  PlannerChangeQuestion({this.increment = true});
}

class PlannerGetLocation extends PlannerQuestionEvent {
  final Mongoose mng;
  PlannerGetLocation({required this.mng});
}

class PlannerQuestionErrorEvent extends PlannerQuestionEvent {
  final String message;
  PlannerQuestionErrorEvent({required this.message});
}

class SaveTrip extends PlannerQuestionEvent {
  final PlannerModel newTrip;
  SaveTrip({required this.newTrip});
}

class PlannerEndQuestion extends PlannerQuestionEvent {}

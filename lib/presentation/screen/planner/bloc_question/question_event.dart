import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/model/location_model.dart';

@immutable
abstract class PlannerQuestionEvent {
  const PlannerQuestionEvent();

  @override
  List<Object> get props => [];
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
  Map<String, dynamic> body;
  SaveTrip({required this.body});
}

class PlannerEndQuestion extends PlannerQuestionEvent {}
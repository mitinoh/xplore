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
  PlannerChangeQuestion({ this.increment =  true});
}


class PlannerQuestionErrorEvent extends PlannerQuestionEvent {
  final String message;
  PlannerQuestionErrorEvent({required this.message});
}
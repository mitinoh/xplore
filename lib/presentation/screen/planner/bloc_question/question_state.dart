import 'package:flutter/material.dart';
import 'package:xplore/data/model/location_model.dart';

@immutable
abstract class PlannerQuestionState {
  const PlannerQuestionState();

  List<Object> get props => [];
}

class PlannerNextQuestion extends PlannerQuestionState {}

class PlannerPreviousQuestion extends PlannerQuestionState {}

class PlannerQuestionInitial extends PlannerQuestionState {}

class PlannerQuestionCompleted extends PlannerQuestionState {}

class PlannerQuestionLocationsLoaded extends PlannerQuestionState {
  final List<LocationModel> locations;
  const PlannerQuestionLocationsLoaded(
      {this.locations = const <LocationModel>[]});

  @override
  List<Object> get props => locations;
}

class PlannerQuestionError extends PlannerQuestionState {
  final String message;
  PlannerQuestionError({required this.message});
}

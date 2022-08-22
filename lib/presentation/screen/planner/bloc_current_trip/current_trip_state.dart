import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/model/planner_model.dart';

@immutable
abstract class CurrentPlannerState extends Equatable {
  const CurrentPlannerState();

  @override
  List<Object> get props => [];
}

class CurrentPlannerInitial extends CurrentPlannerState {}

class CurrentPlannerLoading extends CurrentPlannerState {}

class CurrentPlantripLoadedTrip extends CurrentPlannerState {
  final List<PlannerModel> inProgressTrip;
  const CurrentPlantripLoadedTrip(
      {
      this.inProgressTrip = const <PlannerModel>[]});

  @override
  List<Object> get props => inProgressTrip;
}

class CurrentPlannerError extends CurrentPlannerState {
  final String message;
  CurrentPlannerError(this.message);
}

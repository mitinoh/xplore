import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/data/model/planner_model.dart';

@immutable
abstract class PlannerState extends Equatable {
  const PlannerState();

  @override
  List<Object> get props => [];
}

class PlannerInitial extends PlannerState {}

class PlannerLoading extends PlannerState {}

class PlantripLoadedTrip extends PlannerState {
  final List<PlannerModel> futureTrip;
  final List<PlannerModel> inProgressTrip;
  const PlantripLoadedTrip(
      {this.futureTrip = const <PlannerModel>[],
      this.inProgressTrip = const <PlannerModel>[]});

  @override
  List<Object> get props => [futureTrip, inProgressTrip];
}

class PlannerError extends PlannerState {
  final String message;
  PlannerError(this.message);
}

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/planner_model.dart';

@immutable
abstract class FuturePlannerState extends Equatable {
  const FuturePlannerState();

  @override
  List<Object> get props => [];
}

class FuturePlannerInitial extends FuturePlannerState {}

class FuturePlannerLoading extends FuturePlannerState {}

class FuturePlannerTripLoaded extends FuturePlannerState {
  final List<PlannerModel> futureTrip;
  const FuturePlannerTripLoaded({this.futureTrip = const <PlannerModel>[]});

  @override
  List<Object> get props => futureTrip;
}

class FuturePlannerError extends FuturePlannerState {
  final String message;
  FuturePlannerError(this.message);
}

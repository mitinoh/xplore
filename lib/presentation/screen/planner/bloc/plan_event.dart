import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class PlannerEvent extends Equatable {
  const PlannerEvent();

  @override
  List<Object> get props => [];
}

class GetPlannedTrip extends PlannerEvent {
  const GetPlannedTrip();
}

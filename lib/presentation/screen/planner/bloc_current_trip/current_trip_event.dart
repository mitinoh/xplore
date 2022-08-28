import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CurrentPlannerEvent extends Equatable {
  const CurrentPlannerEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentPlannedTrip extends CurrentPlannerEvent {
  const GetCurrentPlannedTrip();
}

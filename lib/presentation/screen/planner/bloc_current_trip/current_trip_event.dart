import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';

@immutable
abstract class CurrentPlannerEvent extends Equatable {
  const CurrentPlannerEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentPlannedTrip extends CurrentPlannerEvent {
  const GetCurrentPlannedTrip();
}

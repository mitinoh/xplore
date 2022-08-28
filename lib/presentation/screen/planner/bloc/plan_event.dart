import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';

@immutable
abstract class PlannerEvent extends Equatable {
  const PlannerEvent();

  @override
  List<Object> get props => [];
}

class GetPlannedTrip extends PlannerEvent {
  const GetPlannedTrip();
}

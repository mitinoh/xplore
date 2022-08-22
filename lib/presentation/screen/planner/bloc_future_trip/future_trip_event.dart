import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/model/location_model.dart';

@immutable
abstract class FuturePlannerEvent extends Equatable {
  const FuturePlannerEvent();

  @override
  List<Object> get props => [];
}


class GetFuturePlannedTrip extends FuturePlannerEvent {
  const GetFuturePlannedTrip();
}
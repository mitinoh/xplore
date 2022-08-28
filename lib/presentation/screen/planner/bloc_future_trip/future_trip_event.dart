import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class FuturePlannerEvent extends Equatable {
  const FuturePlannerEvent();

  @override
  List<Object> get props => [];
}

class GetFuturePlannedTrip extends FuturePlannerEvent {
  const GetFuturePlannedTrip();
}

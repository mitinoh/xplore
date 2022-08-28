import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetLocationList extends HomeEvent {
  final Mongoose? mongoose;
  const GetLocationList({this.mongoose});
}

class ToggleLikeLocation extends HomeEvent {
  final LocationModel location;
  const ToggleLikeLocation({required this.location});
}

class NavigateToLocation extends HomeEvent {
  final double latitude;
  final double longitude;
  const NavigateToLocation({required this.latitude, required this.longitude});
}

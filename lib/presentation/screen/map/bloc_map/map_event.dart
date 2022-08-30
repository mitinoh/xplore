import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';
@immutable
abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}
/*
class MapGetLocationListEvent extends MapEvent {
  final double latitude;
  final double longitude;
  final double zoom;
  final List<LocationModel> mapLocationList;
  const MapGetLocationListEvent(
      {required this.mapLocationList,
      required this.latitude,
      required this.longitude,
      required this.zoom});

  @override
  List<Object> get props => mapLocationList;
}
*/


class MapGetLocationList extends MapEvent {
  final Mongoose? mongoose;
  final List<LocationModel> listLocations;
  const MapGetLocationList({this.mongoose, this.listLocations = const <LocationModel>[]});


  @override
  List<Object> get props => listLocations;
}



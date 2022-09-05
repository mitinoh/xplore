import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/api/rest_client.dart';
import 'package:xplore/data/dio_provider.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/detail_location_modal.dart';
import 'package:xplore/presentation/screen/map/bloc_map/bloc.dart';
import 'package:xplore/presentation/screen/map/widget/wg_marker.dart';

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
  final MapPosition currentMapPosition;
  const MapGetLocationList({required this.currentMapPosition});
}

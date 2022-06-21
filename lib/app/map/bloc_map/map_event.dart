part of 'map_bloc.dart';

abstract class MapEvent  {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapGetLocationInitEvent extends MapEvent {
  final double latitude;
  final double longitude;
  final double zoom;
  const MapGetLocationInitEvent( {
      required this.latitude,
      required this.longitude,
      required this.zoom});
}

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
  List<Object> get props => [mapLocationList];
}
/*

class GetUserLocation extends MapEvent {
}
*/

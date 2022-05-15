part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetLocationList extends MapEvent {
  final double? x;
  final double? y;
  const GetLocationList({this.x, this.y});
}

class OpeningExternalMap extends MapEvent {
  final double lat;
  final double lng;
  const OpeningExternalMap(this.lat, this.lng);
}

class GetUserLocation extends MapEvent {
}

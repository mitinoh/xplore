part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapGetLocationInitEvent extends MapEvent {
  const MapGetLocationInitEvent();
}

class MapGetLocationListEvent extends MapEvent {
  final List<LocationModel> mapLocationList;
  const MapGetLocationListEvent({required this.mapLocationList});

  @override
  List<Object> get props => [mapLocationList];
}
/*

class GetUserLocation extends MapEvent {
}
*/

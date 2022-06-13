part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];

}

class MapLocationLoadingState extends MapState {
  MapLocationLoadingState();
}

class MapLocationLoadedState extends MapState {
  final List<LocationModel> mapLocation;
  const MapLocationLoadedState({this.mapLocation = const <LocationModel>[]});

  @override
  List<Object> get props => [mapLocation];
}

//class MapLoading extends MapState {}

class MapError extends MapState {
  final String? message;
  const MapError(this.message);
}

/*
class UserLocLoading extends MapState {}

class UserLocLoaded extends MapState {
  final Position? loc;
  const UserLocLoaded(this.loc);
}
*/
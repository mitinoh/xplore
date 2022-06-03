part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapLoaded extends MapState {
  final Position? loc;
  final List<LocationModel> mapModel;
  const MapLoaded(this.mapModel, this.loc);
}

class MapLoading extends MapState {}

class MapError extends MapState {
  final String? message;
  const MapError(this.message);
}

class UserLocLoading extends MapState {}

class UserLocLoaded extends MapState {
  final Position? loc;
  const UserLocLoaded(this.loc);
}

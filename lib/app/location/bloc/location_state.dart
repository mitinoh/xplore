part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationHomeInitial extends LocationState {}

class LocationHomeLoading extends LocationState {}

class LocationHomeLoaded extends LocationState {
  final List<Location> homeModel;
  final bool add;
  const LocationHomeLoaded(this.homeModel, this.add);
}

class LocationError extends LocationState {
  final String? message;
  const LocationError(this.message);
}


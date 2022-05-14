part of 'home_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationHomeInitial extends LocationState {}

class LocationHomeLoading extends LocationState {}

class LocationHomeLoaded extends LocationState {
  final List<Location> homeModel;
  const LocationHomeLoaded(this.homeModel);
}

class LocationError extends LocationState {
  final String? message;
  const LocationError(this.message);
}


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
  const LocationHomeLoaded(this.homeModel);
}

class CreatingNewLocation extends LocationState {}
class CreatedNewLocation extends LocationState {}
class HomeError extends LocationState {
  final String? message;
  const HomeError(this.message);
}

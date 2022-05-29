part of 'saved_location_bloc.dart';

abstract class SavedLocationState extends Equatable {
  const SavedLocationState();

  @override
  List<Object> get props => [];
}

class SavedLocationInitial extends SavedLocationState {}

class SavedLocationLoading extends SavedLocationState {}

class SavedLocationLoaded extends SavedLocationState {
  final List<LocationModel> savedLocationModel;
  const SavedLocationLoaded(this.savedLocationModel);
}

class LocationError extends SavedLocationState {
  final String? message;
  const LocationError(this.message);
}

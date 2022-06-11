part of 'saved_location_bloc.dart';

abstract class SavedLocationState extends Equatable {
  const SavedLocationState();

  @override
  List<Object> get props => [];
}

class SavedLocationLoadingState extends SavedLocationState {}

class SavedLocationLoadedState extends SavedLocationState {
  final List<LocationModel> savedLocationList;
  const SavedLocationLoadedState({this.savedLocationList = const <LocationModel>[]});

  @override
  List<Object> get props => [savedLocationList];
}

class SavedLocationError extends SavedLocationState {
  final String? message;
  const SavedLocationError(this.message);
}

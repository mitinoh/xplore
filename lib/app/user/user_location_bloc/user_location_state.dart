part of 'user_location_bloc.dart';

abstract class UserLocationState {
  const UserLocationState();

  @override
  List<Object> get props => [];
}

class UserLocationInitial extends UserLocationState {}

class UserLocationLoading extends UserLocationState {}

class UserSavedLocationLoaded extends UserLocationState {
  final List<LocationModel> savedLocationModel;
  const UserSavedLocationLoaded(this.savedLocationModel);
  /*
  @override
  List<Object> get props => [
        ...props,
        [1, 2, 3, 4]
      ];
      */
}

class UserUploadedLocationLoaded extends UserLocationState {
  final List<LocationModel> uploadedLocationModel;
  const UserUploadedLocationLoaded(this.uploadedLocationModel);
  /*
  @override
  List<Object> get props => [
        ...props,
        [1, 2, 3, 4]
      ];
      */
}

class UserAllLocationLoaded extends UserLocationState {
  final List<LocationModel> uploadedLocationModel;
  final List<LocationModel> savedLocationModel;
  const UserAllLocationLoaded(
      this.uploadedLocationModel, this.savedLocationModel);
  /*
  const UserAllLocationLoaded({
    this.uploadedLocationModel = const <LocationModel>[],
    this.savedLocationModel = const <LocationModel>[],
  })*/

  @override
  List<Object> get props => [uploadedLocationModel, savedLocationModel];
}

class LocationError extends UserLocationState {
  final String? message;
  const LocationError(this.message);
}

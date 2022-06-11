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

  @override
  List<Object> get props => [savedLocationModel];
}

class UserUploadedLocationLoaded extends UserLocationState {
  final List<LocationModel> uploadedLocationModel;
  const UserUploadedLocationLoaded(this.uploadedLocationModel);
}

class UserAllLocationLoaded extends UserLocationState {

  
  final List<LocationModel> savedLocationModel;
  final List<LocationModel> uploadedLocationModel;
  const UserAllLocationLoaded(
      this.savedLocationModel, this.uploadedLocationModel);

  @override
  List<Object> get props => [savedLocationModel, uploadedLocationModel];
}

class LocationError extends UserLocationState {
  final String? message;
  const LocationError(this.message);
}

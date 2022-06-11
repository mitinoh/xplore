part of 'user_location_bloc.dart';

abstract class UserLocationEvent {
  const UserLocationEvent();

  List<Object> get props => [];
}

class GetUserSavedLocationList extends UserLocationEvent {
  final List<LocationModel> savedLocation;
  const GetUserSavedLocationList(this.savedLocation);


  @override
  List<Object> get props => [savedLocation];
}

class GetUserUploadedLocationList extends UserLocationEvent {
  const GetUserUploadedLocationList();
}

class GetUserAllLocationList extends UserLocationEvent {
  const GetUserAllLocationList();
}

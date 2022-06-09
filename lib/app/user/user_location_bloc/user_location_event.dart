part of 'user_location_bloc.dart';

abstract class UserLocationEvent {
  const UserLocationEvent();

  @override
  List<Object> get props => [];
}

class GetUserSavedLocationList extends UserLocationEvent {
  const GetUserSavedLocationList();
}

class GetUserUploadedLocationList extends UserLocationEvent {
  const GetUserUploadedLocationList();
}


class GetUserAllLocationList extends UserLocationEvent {
  const GetUserAllLocationList();
}

part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetLocationList extends LocationEvent {
  String? searchName;
  GetLocationList({this.searchName});
}

class GetHomeLocationList extends LocationEvent {}

class CreateNewLocation extends LocationEvent {
  String body;
  CreateNewLocation({required this.body});
}

class SaveNewLocation extends LocationEvent {
  String body;
  SaveNewLocation({required this.body});
}

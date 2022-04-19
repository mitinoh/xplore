part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetLocationList extends LocationEvent {
  final String? searchName;
  const GetLocationList({this.searchName});
}

class CreateNewLocation extends LocationEvent {
  final Map<String, dynamic> map;
  const CreateNewLocation({required this.map});
}

class SaveUserLocation extends LocationEvent {
  final Map<String, dynamic> map;
  const SaveUserLocation({required this.map});
}

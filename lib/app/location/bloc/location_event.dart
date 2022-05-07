part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetLocationList extends LocationEvent {
  final String? searchName;
  final bool add;
  final bool? homePage;
  const GetLocationList({this.searchName, required this.add, this.homePage});
}

class CreateNewLocation extends LocationEvent {
  final Map<String, dynamic> map;
  const CreateNewLocation({required this.map});
}

class SaveUserLocation extends LocationEvent {
  final String locationId;
  const SaveUserLocation({required this.locationId});
}

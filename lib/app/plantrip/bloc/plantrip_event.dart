part of 'plantrip_bloc.dart';

abstract class PlantripEvent extends Equatable {
  const PlantripEvent();

  @override
  List<Object> get props => [];
}

class GetLocation extends PlantripEvent {
  String body;
  GetLocation({required this.body});
}

class SaveTrip extends PlantripEvent {
  String body;
  SaveTrip({required this.body});
}

class GetPlannedTrip extends PlantripEvent {
  String body;
  GetPlannedTrip({required this.body});
}

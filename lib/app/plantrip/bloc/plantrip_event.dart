part of 'plantrip_bloc.dart';

abstract class PlantripEvent extends Equatable {
  const PlantripEvent();

  @override
  List<Object> get props => [];
}

class GetLocation extends PlantripEvent {
  String body;
  Mongoose mng;
  GetLocation({required this.body, required this.mng});
}

class SaveTrip extends PlantripEvent {
  String body;
  Mongoose mng;
  SaveTrip({required this.body, required this.mng});
}

class GetPlannedTrip extends PlantripEvent {
  String body;
  GetPlannedTrip({required this.body});
}

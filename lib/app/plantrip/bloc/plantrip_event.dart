part of 'plantrip_bloc.dart';

abstract class PlantripEvent extends Equatable {
  const PlantripEvent();

  @override
  List<Object> get props => [];
}

class GetLocation extends PlantripEvent {
  // String body;
  Mongoose mng;
  GetLocation({/*required this.body,*/ required this.mng});
}

class SaveTrip extends PlantripEvent {
  Map<String, dynamic> body;
  SaveTrip({required this.body});
}

class GetPlannedTrip extends PlantripEvent {
  GetPlannedTrip();
}

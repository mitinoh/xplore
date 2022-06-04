part of 'plantrip_bloc.dart';

abstract class PlantripEvent {
  const PlantripEvent();

  @override
  List<Object> get props => [];
}

class StartQuest extends PlantripEvent {}

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
  const GetPlannedTrip();
}

class PlanTripLocationNotFound extends PlantripEvent {
  String message;
  PlanTripLocationNotFound({required this.message});
}

class PlanTripNextQuestion extends PlantripEvent {}
class PlanTripEndQuestion extends PlantripEvent {}

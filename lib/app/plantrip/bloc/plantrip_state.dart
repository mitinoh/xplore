part of 'plantrip_bloc.dart';

abstract class PlantripState {
  const PlantripState();

  @override
  List<Object> get props => [];
}

class PlantripInitial extends PlantripState {}

class PlantripLoadingLocation extends PlantripState {}

class PlantripLoadedLocation extends PlantripState {
  final List<LocationModel> planTripModel;
  const PlantripLoadedLocation(this.planTripModel);
}

class PlantripLoadingPlannedTrip extends PlantripState {}

class PlantripLoadedPlannedTrip extends PlantripState {
  final List<PlanTripModel> planTripModel;
  final List<PlanTripModel> currentPlanTripModel;
  const PlantripLoadedPlannedTrip(
      this.planTripModel, this.currentPlanTripModel);
}

class LocationHomeLoading extends PlantripState {}

class PlanTripError extends PlantripState {
  final String? message;
  const PlanTripError(this.message);
}

class PlanTripNextQuestion extends PlantripState {
  const PlanTripNextQuestion();
}

class PlanTripPreviousQuestion extends PlantripState {}

class PlanTripQuestion extends PlantripState {}

class PlanTripQuestionCompleted extends PlantripState {}

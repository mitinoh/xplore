part of 'plantrip_bloc.dart';

abstract class PlantripState extends Equatable {
  const PlantripState();

  @override
  List<Object> get props => [];
}

class PlantripInitial extends PlantripState {}

class PlantripLoadingLocation extends PlantripState {}

class PlanTripStartQuest extends PlantripState {}

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

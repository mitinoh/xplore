part of 'plantrip_bloc.dart';

abstract class PlantripState extends Equatable {
  const PlantripState();
  
  @override
  List<Object> get props => [];
}

class PlantripInitial extends PlantripState {}

class PlantripLoadingLocation extends PlantripState {}

class PlantripLoadedLocation extends PlantripState {

  final List<Location> planTripModel;
  const PlantripLoadedLocation(this.planTripModel);
}


class LocationHomeLoading extends PlantripState {}


class PlanTripError extends PlantripState {
  final String? message;
  const PlanTripError(this.message);
}


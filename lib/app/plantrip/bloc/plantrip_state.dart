part of 'plantrip_bloc.dart';

abstract class PlantripState extends Equatable {
  const PlantripState();
  
  @override
  List<Object> get props => [];
}

class PlantripInitial extends PlantripState {}


class LocationHomeLoading extends PlantripState {}

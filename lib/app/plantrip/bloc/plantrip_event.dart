part of 'plantrip_bloc.dart';

abstract class PlantripEvent extends Equatable {
  const PlantripEvent();

  @override
  List<Object> get props => [];
}

class CreateNewLocation extends PlantripEvent {
  String body;
  CreateNewLocation({required this.body});
}

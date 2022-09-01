import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/repository/home_repository.dart';
import 'package:xplore/presentation/screen/new_location/bloc/bloc.dart';
import 'package:xplore/utils/logger.dart';

class NewLocationBloc extends Bloc<NewLocationEvent, NewLocationState> {
  final HomeRepository locationRepository;

  LocationModel newLocation = LocationModel();

  NewLocationBloc({required this.locationRepository}) : super(NewLocationInitial()) {
    on<CreateNewLocation>(_createNewUserLocation);
  }

  void _createNewUserLocation(
      CreateNewLocation event, Emitter<NewLocationState> emit) async {
    try {
      LocationModel location = event.location;
      await locationRepository.createNewLocation(location);
      emit(NewLocationCreated());
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(NewLocationError(e.toString()));
    }
  }
}

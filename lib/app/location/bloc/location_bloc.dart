import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/location/repository/location_repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationHomeInitial()) {
    final LocationRepository _locationRepository = LocationRepository();

    on<GetLocationList>((event, emit) async {
      try {
        emit(LocationHomeLoading());

        Mongoose mng =
            _locationRepository.getMongoose(searchName: event.searchName);

        final mList = await _locationRepository.fetchLocationList(mng: mng);

        emit(LocationHomeLoaded(mList, event.add));
      } catch (e) {
        //throw Exception('FooException');
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });

    on<CreateNewLocation>((event, emit) async {
      try {
        await _locationRepository.newLocationPut(map: event.map);
      } catch (e) {
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });

    on<SaveUserLocation>((event, emit) async {
      try {
        await _locationRepository.saveUserLocationPost(id: event.locationId);
      } catch (e) {
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}

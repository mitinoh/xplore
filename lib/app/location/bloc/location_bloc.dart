import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/location/repository/home_repository.dart';
import 'package:xplore/model/location_model.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationHomeInitial()) {
    final HomeRepository _locationRepository = HomeRepository();
    on<LocationEvent>((event, emit) {});

    on<GetLocationList>((event, emit) async {
      try {
        emit(LocationHomeLoading());

        String pipe =
            _locationRepository.getPipeline(searchName: event.searchName);
        final mList = await _locationRepository.fetchLocationList(body: pipe);

        emit(LocationHomeLoaded(mList));
      } on NetworkError {
        emit(const HomeError("Failed to fetch data. is your device online?"));
      }
    });

    on<CreateNewLocation>((event, emit) async {
      try {
        emit(CreatingNewLocation());
        await _locationRepository.newLocationPut(body: event.body);

        emit(CreatedNewLocation());
      } on NetworkError {
        emit(const HomeError("Failed to fetch data. is your device online?"));
      }
    });

        on<SaveNewLocation>((event, emit) async {
      try {
        //emit(SavingNewLocation());
        await _locationRepository.saveUserLocationPut(body: event.body);

        //emit(SavedNewLocation());
      } on NetworkError {
        emit(const HomeError("Failed to fetch data. is your device online?"));
      }
    });
  }
}

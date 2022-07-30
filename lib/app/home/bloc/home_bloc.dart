import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xplore/app/home/repository/home_repository.dart';
import 'package:xplore/app/user/repository/user_repository.dart';
import 'package:xplore/core/globals.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

import '../../../core/widgets/snackbar_message.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<LocationEvent, LocationState> {
  HomeBloc() : super(LocationHomeInitial()) {
    final HomeRepository _locationRepository = HomeRepository();
    final UserRepository _getUserPosition = UserRepository();
    on<GetLocationList>((event, emit) async {
      try {
        emit(LocationHomeLoading());
        Mongoose mng =
            _locationRepository.getMongoose(searchName: event.searchName);

        final mList = await _locationRepository.getLocationList(mng: mng);
        emit(LocationHomeLoaded(mList));
      } catch (e) {
        log(e.toString());
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });

    on<CreateNewLocation>((event, emit) async {
      try {
        await _locationRepository.newLocationPost(map: event.map);
      } catch (e) {
        log(e.toString());
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });

    on<SaveUserLocation>((event, emit) async {
      try {
        await _locationRepository.saveUserLocationPost(
            id: event.locationId, save: event.save);
      } catch (e) {
        log(e.toString());
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });

    on<VerifyIfLocationsNearby>((event, emit) async {
      try {
        Position userPos = await _getUserPosition.getUserPosition();

        /*
          BlocProvider.of<HomeBloc>(context).add(
            VerifyIfLocationsNearby(),
        );
        */
        Mongoose mng = Mongoose(filter: []);
        mng.filter?.add(Filter(
            key: "latitude",
            operation: "=",
            value: userPos.latitude.toString()));
        mng.filter?.add(Filter(
            key: "longitude",
            operation: "=",
            value: userPos.longitude.toString()));
        mng.filter?.add(
            Filter(key: "distance", operation: "=", value: (3).toString()));

        final List<LocationModel> mapList =
            await _locationRepository.getLocationList(mng: mng);

        if (mapList.isNotEmpty) {
          // emettere evento

          mapList.forEach((loc) {
            Map<String, String> map = {"location": loc.iId ?? ''};
            _locationRepository.visitedLocationPost(map: map);
          });
        } else {
          final SnackBar snackBar = SnackBar(
              content: Text(
                  "sembra che non ti trovi in un nessun posto al momento"));
          snackbarKey.currentState?.showSnackBar(snackBar);
        }
      } catch (e) {
        log(e.toString());
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });

    on<VerifyIfOnLocation>((event, emit) async {
      try {
        Position userPos = await _getUserPosition.getUserPosition();
        Mongoose mng = Mongoose(filter: []);
        mng.filter?.add(Filter(
            key: "latitude",
            operation: "=",
            value: userPos.latitude.toString()));
        mng.filter?.add(Filter(
            key: "longitude",
            operation: "=",
            value: userPos.longitude.toString()));
        mng.filter
            ?.add(Filter(key: "_id", operation: "=", value: event.locationId));

        mng.filter?.add(
            Filter(key: "distance", operation: "=", value: (3).toString()));

        final List<LocationModel> mapList =
            await _locationRepository.getLocationList(mng: mng);

        if (mapList.isNotEmpty) {
          // emettere evento
          final SnackBar snackBar = SnackBar(content: Text("trovati"));
          snackbarKey.currentState?.showSnackBar(snackBar);

          mapList.forEach((loc) {
            Map<String, String> map = {"location": loc.iId ?? ''};
            _locationRepository.visitedLocationPost(map: map);
          });
        }
      } catch (e) {
        log(e.toString());
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}

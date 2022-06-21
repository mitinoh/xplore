import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xplore/app/map/repository/map_repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapLocationLoadingState()) {
    final MapRepository _mapRepository = MapRepository();

    on<MapGetLocationInitEvent>((event, emit) async {
      try {
        final mapList = await _mapRepository.getLocationList(mng: Mongoose());
        emit(MapLocationLoadedState(mapLocation: mapList));
        /*
        Timer(const Duration(milliseconds: 50), () {
          lc.LocationData? _userLocation;
          emit(MapLoaded(mList, _userLocation));
        });
        */

        // final userLoc = await _mapRepository.getUserPosition();
        // log(userLoc.toString());
        //final userLoc =  lc.LocationData;

        // emit(MapLoaded(mList, userLoc));
      } catch (e, stacktrace) {
      log(stacktrace.toString());
      emit(MapError(e.toString()));
      }
    });

    on<MapGetLocationListEvent>((event, emit) async {
      try {

      final state = this.state;

        final newMapList = await _mapRepository.getLocationList(mng: Mongoose());
        if (state is MapLocationLoadedState) {
        emit(
          MapLocationLoadedState(mapLocation: [
            ...state.mapLocation,
            ...newMapList
          ]),
        );
      }
        /*
        Timer(const Duration(milliseconds: 50), () {
          lc.LocationData? _userLocation;
          emit(MapLoaded(mList, _userLocation));
        });
        */

        // final userLoc = await _mapRepository.getUserPosition();
        // log(userLoc.toString());
        //final userLoc =  lc.LocationData;

        // emit(MapLoaded(mList, userLoc));
      } catch (e, stacktrace) {
      log(stacktrace.toString());
      emit(MapError(e.toString()));
      }
    });
/*
    on<OpeningExternalMap>((event, emit) async {
      try {
        _mapRepository.openMap(event.lat, event.lng);
      } catch (e) {
        log(e.toString());
        emit(const MapError("Failed to fetch data. is your device online?"));
      }
    });
    */
/*
    on<GetUserLocation>((event, emit) async {
      try {
        emit(UserLocLoading());
        final userLoc = await _mapRepository.getUserPosition();
        log(userLoc);
        emit(UserLocLoaded(userLoc));
      } catch (e) {
        emit(const MapError("Failed to fetch data. is your device online?"));
      }
    });
    */
  }
}
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart' as lc;
import 'package:xplore/app/map/repository/map_repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    final MapRepository _mapRepository = MapRepository();
    on<MapEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetLocationList>((event, emit) async {
      try {
        emit(MapLoading());

        String pipe = _mapRepository.getPipelineMap(x: event.x, y: event.y);
        final mList = await _mapRepository.fetchLocationList(mng: Mongoose());
        Timer(Duration(milliseconds: 50), () {
          lc.LocationData? _userLocation;
          emit(MapLoaded(mList, _userLocation));
        });
        // FIXME: non risponde quasi mai stammerda
        final userLoc = await _mapRepository.getUserLocation();
        //final userLoc =  lc.LocationData;

        // log(userLoc.toString());
        emit(MapLoaded(mList, userLoc));
      } catch (e) {
        emit(const MapError("Failed to fetch data. is your device online?"));
      }
    });

    on<OpeningExternalMap>((event, emit) async {
      try {
        _mapRepository.openMap(event.lat, event.lng);
      } catch (e) {
        emit(const MapError("Failed to fetch data. is your device online?"));
      }
    });

    /*on<GetUserLocation>((event, emit) async {
      try {
        // emit(UserLocLoading());
        final userLoc = await _mapRepository.getUserLocation();
        //emit(UserLocLoaded(userLoc));
      } on NetworkError {
        emit(const MapError("Failed to fetch data. is your device online?"));
      }
    });*/
  }
}

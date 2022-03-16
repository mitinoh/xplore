import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/map/repository/map_repository.dart';
import 'package:xplore/model/location_model.dart';

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
        String pipe = _mapRepository.getPipelineMap(x: event.x, y: event.y);
        final mList = await _mapRepository.fetchLocationList(body: pipe);

        emit(MapLoaded(mList));
      } on NetworkError {
        emit(const MapError("Failed to fetch data. is your device online?"));
      }
    });

    on<OpeningExternalMap>((event, emit) async {
      try {
        _mapRepository.openMap(event.lat, event.lng);
      } on NetworkError {
        emit(const MapError("Failed to fetch data. is your device online?"));
      }
    });
  }
}

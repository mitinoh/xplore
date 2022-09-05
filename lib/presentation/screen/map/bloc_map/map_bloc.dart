import 'package:bloc/bloc.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/repository/home_repository.dart';
import 'package:xplore/presentation/screen/map/bloc_map/bloc.dart';
import 'package:xplore/utils/logger.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final HomeRepository locationRepository;
  MapBloc({required this.locationRepository}) : super(MapLocationInitial()) {
    on<MapGetLocationList>(_getUserPosition);
  }

  void _getUserPosition(MapGetLocationList event, Emitter<MapState> emit) async {
    try {
      final state = this.state;
      List<LocationModel> listLocations = [];
      if (state is MapLocationLoaded) {
        listLocations = state.locationList;
      }

      Mongoose mng = locationRepository.getMapMongoose(
        event.currentMapPosition, listLocations
      );

      final List<LocationModel> newLocations =
          await locationRepository.getLocationList(mng);
      emit(MapLocationLoaded(locationList: [...listLocations, ...newLocations]));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(MapError(e.toString()));
    }
  }
}

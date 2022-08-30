import 'package:bloc/bloc.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/repository/home_repository.dart';
import 'package:xplore/data/repository/user_repository.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';
import 'package:xplore/presentation/screen/map/bloc_map/bloc.dart';
import 'package:xplore/presentation/screen/map/bloc_user_position/bloc.dart';
import 'package:xplore/utils/logger.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final HomeRepository locationRepository;
  MapBloc({required this.locationRepository}) : super(MapLocationInitial()) {
    on<MapGetLocationList>(_getUserPosition);
  }

  void _getUserPosition(MapGetLocationList event, Emitter<MapState> emit) async {
    try {
      List<String?> idToAVoid = [];
      event.listLocations.forEach((m) => idToAVoid.add(m.id));

      //final state = this.state;
      Mongoose mng = event.mongoose != null ? event.mongoose! : Mongoose();

      /*
        mng.filter?.add(Filter(
            key: "latitude", operation: "=", value: event.latitude.toString()));
        mng.filter?.add(Filter(
            key: "longitude",
            operation: "=",
            value: event.longitude.toString()));
        mng.filter?.add(Filter(
            key: "distance",
            operation: "=",
            value: (event.zoom * 1000).toString()));
            */

      if (idToAVoid.isNotEmpty) {
        mng.filter?.add(Filter(key: "_id", operation: "!=", value: idToAVoid.join(',')));
      }

      final List<LocationModel> newLocations =
          await locationRepository.getLocationList(mng);
      emit(MapLocationLoaded(locationList: [...event.listLocations, ...newLocations]));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(MapError(e.toString()));
    }
  }
}

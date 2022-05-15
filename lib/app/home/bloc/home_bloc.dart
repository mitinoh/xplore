import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/home/repository/home_repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<LocationEvent, LocationState> {
  HomeBloc() : super(LocationHomeInitial()) {
    final HomeRepository _locationRepository = HomeRepository();

    on<GetLocationList>((event, emit) async {
      try {
        emit(LocationHomeLoading());
        Mongoose mng =
            _locationRepository.getMongoose(searchName: event.searchName);

        final mList = await _locationRepository.getLocationList(mng: mng);
        emit(LocationHomeLoaded(mList));
      } catch (e) {
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });

    on<CreateNewLocation>((event, emit) async {
      try {
        await _locationRepository.newLocationPost(map: event.map);
      } catch (e) {
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });

    on<SaveUserLocation>((event, emit) async {
      try {
        await _locationRepository.saveUserLocationPost(
            id: event.locationId, save: event.save);
      } catch (e) {
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}

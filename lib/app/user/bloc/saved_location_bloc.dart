import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/user/repository/user_repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

part 'saved_location_event.dart';
part 'saved_location_state.dart';

class SavedLocationBloc extends Bloc<SavedLocationEvent, SavedLocationState> {
  SavedLocationBloc() : super(SavedLocationInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<SavedLocationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetSavedLocationList>((event, emit) async {
      try {
        emit(SavedLocationLoading());

        Mongoose mng =
            Mongoose(filter: {}, select: ["-uid", "-cdate", "-_id"], sort: {});
        final mList = await _userRepository.getSavedLocationList(mng);
        emit(SavedLocationLoaded(mList));
      } catch (e) {
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/repository/user_repository.dart';
import 'package:xplore/presentation/screen/user/bloc_saved_location/bloc.dart';
import 'package:xplore/utils/logger.dart';

class SavedLocationBloc extends Bloc<SavedLocationEvent, SavedLocationState> {
  final UserRepository _userRepository = UserRepository();
  SavedLocationBloc() : super(SavedLocationLoadingState()) {
    on<GetUserSavedLocationList>(_onGetSavedLocationUserList);
  }

  void _onGetSavedLocationUserList(
    GetUserSavedLocationList event,
    Emitter<SavedLocationState> emit,
  ) async {
    try {
      Mongoose mng = _userRepository.getMongooseSavedLocation(event: event);
      final List<LocationModel> newSavedLocationList =
          await _userRepository.getUserSavedLocation(mng);

      emit(
        SavedLocationLoadedState(savedLocationList: [
          ...event.savedLocationList,
          ...newSavedLocationList,
        ]),
      );
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(SavedLocationError(e.toString()));
    }
  }
}

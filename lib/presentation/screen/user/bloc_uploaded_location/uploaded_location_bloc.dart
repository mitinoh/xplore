import 'package:bloc/bloc.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/repository/user_repository.dart';
import 'package:xplore/presentation/screen/user/bloc_uploaded_location/bloc.dart';
import 'package:xplore/utils/logger.dart';

class UploadedLocationBloc extends Bloc<UploadedLocationEvent, UploadedLocationState> {
  final UserRepository _userRepository = UserRepository();
  UploadedLocationBloc() : super(UploadedLocationLoadingState()) {
    on<GetUserUploadedLocationList>(_onGetUploadedLocationUserList);
  }

  void _onGetUploadedLocationUserList(
    GetUserUploadedLocationList event,
    Emitter<UploadedLocationState> emit,
  ) async {
    try {
      List<String> exlcudeId = [];

      event.uploadedLocationList.forEach((location) => exlcudeId.add(location.id.toString()));

      Mongoose mng = _userRepository.getMongooseUploadedLocation(event: event);
      final List<LocationModel> newUploadedLocationList =
          await _userRepository.getUserUploadedLocation(mng);

      emit(
        UploadedLocationLoadedState(uploadedLocationList: [
          ...event.uploadedLocationList,
          ...newUploadedLocationList
        ]),
      );
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(UploadedLocationError(e.toString()));
    }
  }
}

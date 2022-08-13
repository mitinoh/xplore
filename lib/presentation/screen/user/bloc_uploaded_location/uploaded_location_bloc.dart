import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/repository/user_repository.dart';
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

      event.uploadedLocationList
          .map((location) => exlcudeId.add(location.id.toString()));

      Mongoose mng = Mongoose(filter: [
        Filter(key: 'uid', operation: '=', value: event.uid),
        Filter(key: '_id', operation: '!=', value: exlcudeId.join(','))
      ]);
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

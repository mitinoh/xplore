import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:xplore/app/user/repository/user_repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

part 'user_location_event.dart';
part 'user_location_state.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState> {
  UserLocationBloc() : super(UserLocationInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<UserLocationEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetUserAllLocationList>((event, emit) async {
      try {
        emit(UserLocationLoading());

        final state = this.state;
        Mongoose mng =
            Mongoose(filter: {}, select: ["-uid", "-cdate"], sort: {});
        final savedLocationList =
            await _userRepository.getSavedLocationList(mng);
        final uploadedLocationList =
            await _userRepository.getUploadedLocationList(mng);

        log(savedLocationList.toString());
        emit(UserAllLocationLoaded(savedLocationList, uploadedLocationList));
      } catch (e, stacktrace) {
        log(stacktrace.toString());
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });

    // TODO: rifare tutta questa parte mettendo i valori dentro props
    on<GetUserSavedLocationList>((event, emit) async {
      try {
        emit(UserSavedLocationLoaded(event.savedLocation));

        final state = this.state;
        Mongoose mng =
            Mongoose(filter: {}, select: ["-uid", "-cdate"], sort: {});
        final savedLocationList =
            await _userRepository.getSavedLocationList(mng);
        if (state is UserSavedLocationLoaded) {
          state.savedLocationModel;
          log(savedLocationList.toString());
          emit(UserSavedLocationLoaded(
              [...state.savedLocationModel, ...savedLocationList]));
        }
      } catch (e, stacktrace) {
        log(stacktrace.toString());
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });
    on<GetUserUploadedLocationList>((event, emit) async {
      try {
        emit(UserLocationLoading());
        Mongoose mng =
            Mongoose(filter: {}, select: ["-uid", "-cdate"], sort: {});
        final uploadedLocationList =
            await _userRepository.getUploadedLocationList(mng);
        log(uploadedLocationList.toString());
        emit(UserUploadedLocationLoaded(uploadedLocationList));
      } catch (e, stacktrace) {
        log(stacktrace.toString());
        emit(const LocationError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}

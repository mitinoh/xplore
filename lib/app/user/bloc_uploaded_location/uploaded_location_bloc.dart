import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/user/repository/user_repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

part 'uploaded_location_event.dart';
part 'uploaded_location_state.dart';

class UploadedLocationBloc
    extends Bloc<UploadedLocationEvent, UploadedLocationState> {
  final UserRepository _userRepository = UserRepository();
  UploadedLocationBloc() : super(UploadedLocationLoadingState()) {
    on<UploadedLocationInitUserListEvent>(_onInitUploadedLocationUserList);
    on<UploadedLocationGetUserListEvent>(_onGetUploadedLocationUserList);
  }

  void _onInitUploadedLocationUserList(
    UploadedLocationEvent event,
    Emitter<UploadedLocationState> emit,
  ) async {
    try {
      // TODO: impostare limite
      Mongoose mng = Mongoose(filter: {}, select: ["-uid", "-cdate"], sort: {});
      final newUploadedLocationList =
          await _userRepository.getUploadedLocationList(mng);

      emit(
        UploadedLocationLoadedState(uploadedLocationList: newUploadedLocationList),
      );
    } catch (e, stacktrace) {
      log(stacktrace.toString());
      emit(UploadedLocationError(e.toString()));
    }
  }

  void _onGetUploadedLocationUserList(
    UploadedLocationEvent event,
    Emitter<UploadedLocationState> emit,
  ) async {
    try {
      final state = this.state;
      Mongoose mng = Mongoose(filter: {}, select: ["-uid", "-cdate"], sort: {});
      final newUploadedLocationList =
          await _userRepository.getUploadedLocationList(mng);

      if (state is UploadedLocationLoadedState) {
        emit(
          UploadedLocationLoadedState(uploadedLocationList: [
            ...state.uploadedLocationList,
            ...newUploadedLocationList
          ]),
        );
      }
    } catch (e, stacktrace) {
      log(stacktrace.toString());
      emit(UploadedLocationError(e.toString()));
    }
  }
}

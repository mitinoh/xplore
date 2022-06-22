import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/user/repository/user_repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

part 'saved_location_event.dart';
part 'saved_location_state.dart';

class SavedLocationBloc extends Bloc<SavedLocationEvent, SavedLocationState> {
  final UserRepository _userRepository = UserRepository();
  SavedLocationBloc() : super(SavedLocationLoadingState()) {
    on<SavedLocationInitUserListEvent>(_onInitSavedLocationUserList);
    on<SavedLocationGetUserListEvent>(_onGetSavedLocationUserList);
  }

  void _onInitSavedLocationUserList(
    SavedLocationEvent event,
    Emitter<SavedLocationState> emit,
  ) async {
    try {
      // TODO: impostare limite
      Mongoose mng = Mongoose(select: ["-uid", "-cdate"]);
      final newSavedLocationList =
          await _userRepository.getSavedLocationList(mng);

      emit(
        SavedLocationLoadedState(savedLocationList: newSavedLocationList),
      );
    } catch (e, stacktrace) {
      log(stacktrace.toString());
      emit(SavedLocationError(e.toString()));
    }
  }

  void _onGetSavedLocationUserList(
    SavedLocationEvent event,
    Emitter<SavedLocationState> emit,
  ) async {
    try {
      final state = this.state;
      Mongoose mng = Mongoose(select: ["-uid", "-cdate"]);
      final newSavedLocationList =
          await _userRepository.getSavedLocationList(mng);

      if (state is SavedLocationLoadedState) {
        emit(
          SavedLocationLoadedState(savedLocationList: [
            ...state.savedLocationList,
            ...newSavedLocationList
          ]),
        );
      }
    } catch (e, stacktrace) {
      log(stacktrace.toString());
      emit(SavedLocationError(e.toString()));
    }
  }
}

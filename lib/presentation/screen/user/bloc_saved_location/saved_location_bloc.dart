import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/screen/user/bloc_saved_location/bloc.dart';


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
      //final state = this.state;
      List<String> exlcudeId = [];

      event.savedLocationList
          .map((location) => exlcudeId.add(location.id.toString()));

      Mongoose mng = Mongoose(filter: [
        Filter(key: 'uid', operation: '=', value: event.uid),
        Filter(key: '_id', operation: '!=', value: exlcudeId.join(','))
      ]);
      final List<LocationModel> newSavedLocationList =
          await _userRepository.getUserSavedLocation(mng);

      emit(
        SavedLocationLoadedState(savedLocationList: [
          ...event.savedLocationList,
          ...newSavedLocationList
        ]),
      );
    } catch (e, stacktrace) {
      log(stacktrace.toString());
      emit(SavedLocationError(e.toString()));
    }
  }
}

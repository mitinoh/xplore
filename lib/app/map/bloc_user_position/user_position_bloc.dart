import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xplore/app/user/repository/user_repository.dart';

part 'user_position_event.dart';
part 'user_position_state.dart';

class UserPositionBloc extends Bloc<UserPositionEvent, UserPositionState> {
  final UserRepository _userRepository = UserRepository();
  UserPositionBloc() : super(UserPositionLoading()) {
    on<GetUserPositionEvent>((event, emit) async {
      emit(UserPositionLoaded(
          userPosition: await _userRepository.getUserPosition()));
    });
  }
}

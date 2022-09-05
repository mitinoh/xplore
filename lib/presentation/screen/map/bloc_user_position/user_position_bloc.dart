import 'package:bloc/bloc.dart';
import 'package:xplore/data/repository/user_repository.dart';
import 'package:xplore/presentation/screen/map/bloc_user_position/bloc.dart';
import 'package:xplore/utils/logger.dart';

class UserPositionBloc extends Bloc<UserPositionEvent, UserPositionState> {
  final UserRepository userRepository;
  UserPositionBloc({required this.userRepository}) : super(UserPositionLoading()) {
    on<GetUserPosition>(_getUserPosition);
  }

  void _getUserPosition(
      GetUserPosition event, Emitter<UserPositionState> emit) async {
    try {
      emit(UserPositionLoaded(
          userPosition: await userRepository.getUserPosition()));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(UserPositionError(e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/screen/user/bloc_user/bloc.dart';
import 'package:xplore/utils/logger.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<UpdateUserInfo>(_updateUserInfo);
    on<GetUserData>(_getUserData);
    on<UpdateUserData>(_updateUserData);
  }

  void _updateUserInfo(UpdateUserInfo event, Emitter<UserState> emit) async {
    try {} catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(UserError(e.toString()));
    }
  }

  void _getUserData(GetUserData event, Emitter<UserState> emit) async {
    try {
      late UserModel userData;
      if (event.fid != null) {
        userData = await userRepository.getUserData(event.fid!);
      } else {
        userData = event.user!;
      }
      emit(UserDataLoaded(userData: userData));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(UserError(e.toString()));
    }
  }

  void _updateUserData(UpdateUserData event, Emitter<UserState> emit) async {
    try {
      final state = this.state;
      if (state is UserDataLoaded) {
        UserModel newUserData =
            event.newUserData.copyWith(id: state.userData.id);

        UserModel updatedUserData = UserModel.fromJson(
            {...state.userData.toJson(), ...newUserData.toJson()});

        userRepository.updateUserData(updatedUserData);

        emit(UserDataLoaded(userData: updatedUserData));
      }
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(UserError(e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/data/repository/auth_repository.dart';
import 'package:xplore/data/repository/user_repository.dart';
import 'package:xplore/presentation/screen/user/bloc_user/bloc.dart';
import 'package:xplore/utils/logger.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<UpdateUserInfo>(_updateUserInfo);
    on<GetUserData>(_getUserData);
    on<UpdateUserData>(_updateUserData);
    on<CreateNewUser>(_createNewUser);
    on<UploadNewImage>(_uploadNewImage);
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
        userData = await userRepository.getFidUserData(event.fid!);
      } else {
        userData = event.user!;
      }
      emit(UserDataLoaded(userData: userData));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());

      emit(UserDataLoaded(userData: UserModel()));
      //emit(UserError(e.toString()));
    }
  }

  void _updateUserData(UpdateUserData event, Emitter<UserState> emit) async {
    try {
      final state = this.state;
      UserModel updatedUserData;
      if (state is UserDataLoaded) {
        if (state.userData.id == null) {
          await userRepository.createNewUser(event.newUserData);
          updatedUserData = event.newUserData;
        } else {
          UserModel newUserData = event.newUserData.copyWith(id: state.userData.id);

          updatedUserData =
              UserModel.fromJson({...state.userData.toJson(), ...newUserData.toJson()});
        }
      } else {
        updatedUserData = event.newUserData;
      }

      userRepository.updateUserData(updatedUserData);

      emit(UserDataLoaded(userData: updatedUserData));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(UserError(e.toString()));
    }
  }

  void _createNewUser(CreateNewUser event, Emitter<UserState> emit) async {
    try {
      if (await userRepository.isUserNameAvaiable(event.userData.username ?? '')) {
        await userRepository.createNewUser(event.userData);
        emit(UserDataLoaded(userData: event.userData));
      } else {
        emit(UserError("Username already taken"));
      }
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(UserError(e.toString()));
    }
  }

  void _uploadNewImage(UploadNewImage event, Emitter<UserState> emit) async {
    try {
      String userId = await AuthRepository().getUserFid();
      userRepository.uploadUserImage(userId, event.formData);
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(UserError(e.toString()));
    }
  }
}

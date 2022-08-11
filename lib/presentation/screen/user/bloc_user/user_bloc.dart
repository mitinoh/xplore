import 'package:bloc/bloc.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:xplore/model/repository/home_repository.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/screen/user/bloc_user/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<UpdateUserInfo>(_updateUserInfo);
    on<GetUserData>(_getUserData);
  }

  void _updateUserInfo(UpdateUserInfo event, Emitter<UserState> emit) async {
    try {} catch (_) {}
  }

  void _getUserData(GetUserData event, Emitter<UserState> emit) async {
    try {
      UserModel userData = await userRepository.getUserData(event.fid);
      emit(UserDataLoaded(userData: userData));
    } catch (e) {}
  }
}

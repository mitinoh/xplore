import 'package:bloc/bloc.dart';
import 'package:xplore/model/repository/home_repository.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/screen/user/bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<UpdateUserInfo>(_updateUserInfo);
  }

  void _updateUserInfo(UpdateUserInfo event, Emitter<UserState> emit) async {
    try {} catch (_) {}
  }
}

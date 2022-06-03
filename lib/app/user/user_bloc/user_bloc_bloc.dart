import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/user/repository/user_repository.dart';

part 'user_bloc_event.dart';
part 'user_bloc_state.dart';

class UserBlocBloc extends Bloc<UserBlocEvent, UserBlocState> {
  UserBlocBloc() : super(UserBlocInitial()) {
    final UserRepository _userRepository = UserRepository();
    on<UserBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UpdateUserInfo>(((event, emit) {
      _userRepository.updateUserInfo(event.map);
      emit(const UpdatedUserInfo());
    }));
  }
}

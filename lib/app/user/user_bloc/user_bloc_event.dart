part of 'user_bloc_bloc.dart';

abstract class UserBlocEvent extends Equatable {
  const UserBlocEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserInfo extends UserBlocEvent {

  final Map<String, dynamic> map;
  const UpdateUserInfo(this.map);
}
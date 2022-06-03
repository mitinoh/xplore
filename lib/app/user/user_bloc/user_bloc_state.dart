part of 'user_bloc_bloc.dart';

abstract class UserBlocState extends Equatable {
  const UserBlocState();
  
  @override
  List<Object> get props => [];
}

class UserBlocInitial extends UserBlocState {}



class UpdatedUserInfo extends UserBlocState {
  const UpdatedUserInfo();
}

class UserInfoError extends UserBlocState {
  final String? message;
  const UserInfoError(this.message);
}

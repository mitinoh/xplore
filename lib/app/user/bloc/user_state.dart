part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> userModel;
  const UserLoaded(this.userModel);
}

class UserAdded extends UserState {}

class UserError extends UserState {
  late final String? message;

  UserError(String? error);
}

part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserList extends UserEvent {}

class AddedUserElement extends UserEvent {}

class Test extends UserEvent {

  int amount = 0;
  Test({required this.amount});
}

part of 'user_position_bloc.dart';

abstract class UserPositionEvent extends Equatable {
  const UserPositionEvent();

  @override
  List<Object> get props => [];
}


class GetUserPositionEvent extends UserPositionEvent {
  const GetUserPositionEvent();
}

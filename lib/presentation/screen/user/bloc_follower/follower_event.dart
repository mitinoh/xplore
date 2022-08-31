import 'package:equatable/equatable.dart';

abstract class FollowerEvent extends Equatable {
  const FollowerEvent();

  @override
  List<Object> get props => [];
}

class IsFollowingUser extends FollowerEvent {
  final String uid;
  IsFollowingUser({required this.uid});
}

class ToggleFollow extends FollowerEvent {
  final String uid;
  final bool following;
  ToggleFollow({required this.uid, required this.following});
}

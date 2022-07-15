part of 'follower_bloc.dart';

abstract class FollowerEvent extends Equatable {
  const FollowerEvent();

  @override
  List<Object> get props => [];
}

class FollowerGetListEvent extends FollowerEvent {
  final String? uid;
  const FollowerGetListEvent({this.uid});
}

class FollowerFollowUserEvent extends FollowerEvent {
  final String uid;
  const FollowerFollowUserEvent({required this.uid});
}
class FollowerUnfollowUserEvent extends FollowerEvent {
  final String uid;
  const FollowerUnfollowUserEvent({required this.uid});
}

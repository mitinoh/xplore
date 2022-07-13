part of 'follower_count_bloc.dart';

abstract class FollowerCountEvent extends Equatable {
  const FollowerCountEvent();

  @override
  List<Object> get props => [];
}

class FollowerGetCountListEvent extends FollowerCountEvent {
  final String? uid;
  const FollowerGetCountListEvent({this.uid});
}

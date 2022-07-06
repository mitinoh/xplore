part of 'follower_bloc.dart';

abstract class FollowerState extends Equatable {
  const FollowerState();

  @override
  List<Object> get props => [];
}

class FollowerInitial extends FollowerState {}

class FollowerLoadedState extends FollowerState {
  final FollowerModel followerList;
  const FollowerLoadedState(this.followerList);
}

class FollowerError extends FollowerState {
  final String? message;
  const FollowerError(this.message);
}

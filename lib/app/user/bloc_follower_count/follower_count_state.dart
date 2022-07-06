part of 'follower_count_bloc.dart';

abstract class FollowerCountState extends Equatable {
  const FollowerCountState();

  @override
  List<Object> get props => [];
}

class FollowerCountInitial extends FollowerCountState {}

class FollowerCountLoadedState extends FollowerCountState {
  final FollowerCountModel followerCount;
  const FollowerCountLoadedState(this.followerCount);
}

class FollowerError extends FollowerCountState {
  final String? message;
  const FollowerError(this.message);
}

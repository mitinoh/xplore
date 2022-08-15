import 'package:xplore/model/model/location_model.dart';
import 'package:equatable/equatable.dart';


abstract class FollowerState extends Equatable {
  const FollowerState();

  @override
  List<Object> get props => [];
}

class FollowerLoadingState extends FollowerState{}

class FollowingUser extends FollowerState {
  final bool following;
  const FollowingUser({this.following =  false});

  @override
  List<Object> get props => [following];
}

class FollowerError extends FollowerState {
  final String? message;
  const FollowerError(this.message);
}

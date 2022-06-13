part of 'user_position_bloc.dart';

abstract class UserPositionState extends Equatable {
  const UserPositionState();
  
  @override
  List<Object> get props => [];
}

class UserPositionLoading extends UserPositionState {}
class UserPositionLoaded extends UserPositionState {

   final Position userPosition;
  const UserPositionLoaded({this.userPosition = const Position(longitude: 12.496366, latitude: 41.902782,  accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0, timestamp: null)});

}

class UserPositionError extends UserPositionState {
  final String? message;
  const UserPositionError(this.message);
}


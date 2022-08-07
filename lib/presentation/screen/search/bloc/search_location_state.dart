import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class SearchLocationState extends Equatable {
  const SearchLocationState();

  @override
  List<Object> get props => [];
}

class SearchLocationInitial extends SearchLocationState {}

class SearchLocationLoading extends SearchLocationState {}

class SearchLocationLoaded extends SearchLocationState {
  final List<LocationModel> searchLocation;
  const SearchLocationLoaded(this.searchLocation);

  @override
  List<LocationModel> get props => this.searchLocation;
}

class SearchUserLoading extends SearchLocationState {}

class SearchUserLoaded extends SearchLocationState {
  final List<UserModel> searchUser;
  const SearchUserLoaded(this.searchUser);

  @override
  List<UserModel> get props => this.searchUser;
}

class SearchLocationError extends SearchLocationState {
  final String? message;
  const SearchLocationError(this.message);
}

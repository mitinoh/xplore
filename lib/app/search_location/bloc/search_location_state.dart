part of 'search_location_bloc.dart';

abstract class SearchLocationState extends Equatable {
  const SearchLocationState();

  @override
  List<Object> get props => [];
}

class SearchLocationInitial extends SearchLocationState {}

class SearchLocationLoading extends SearchLocationState {}

class SearchLocationLoaded extends SearchLocationState {
  final List<LocationModel> searchLocationModel;
  final bool add;
  const SearchLocationLoaded(this.searchLocationModel, this.add);
}

class SearchUserLoading extends SearchLocationState {}

class SearchUserLoaded extends SearchLocationState {
  final List<UserModel> searchUserModel;
  const SearchUserLoaded(
    this.searchUserModel,
  );
}

/*
class SuggestedLocationNameLoading extends SearchLocationState {
}
class SuggestedLocationNameLoaded extends SearchLocationState {
  final List<LocationModel> searchLocationName;
  const SuggestedLocationNameLoaded(this.searchLocationName);
}
*/
class SearchLocationError extends SearchLocationState {
  final String? message;
  const SearchLocationError(this.message);
}

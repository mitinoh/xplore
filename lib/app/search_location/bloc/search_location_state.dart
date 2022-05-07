part of 'search_location_bloc.dart';

abstract class SearchLocationState extends Equatable {
  const SearchLocationState();
  
  @override
  List<Object> get props => [];
}

class SearchLocationInitial extends SearchLocationState {}


class SearchLocationLoading extends SearchLocationState {}

class SearchLocationLoaded extends SearchLocationState {
  final List<Location> searchLocationModel;
  final bool add;
  const SearchLocationLoaded(this.searchLocationModel, this.add);
}

class SearchLocationError extends SearchLocationState {
 
  final String? message;
  const SearchLocationError(this.message);
}

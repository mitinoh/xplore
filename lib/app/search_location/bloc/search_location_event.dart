part of 'search_location_bloc.dart';

abstract class SearchLocationEvent extends Equatable {
  const SearchLocationEvent();

  @override
  List<Object> get props => [];

  
}
class GetSearchLocationList extends SearchLocationEvent {
  final String? searchName;
  final bool add;
  const GetSearchLocationList({this.searchName, required this.add});
}
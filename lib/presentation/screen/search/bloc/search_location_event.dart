import 'package:equatable/equatable.dart';

abstract class SearchLocationEvent extends Equatable {
  const SearchLocationEvent();

  @override
  List<Object> get props => [];
}

class GetSearchLocationList extends SearchLocationEvent {
  final String? searchName;
  const GetSearchLocationList({this.searchName});
}

class GetSuggestedNameLocationList extends SearchLocationEvent {
  final String? searchName;
  const GetSuggestedNameLocationList({this.searchName});
}

class GetSearchUsersList extends SearchLocationEvent {
  final String? searchName;
  const GetSearchUsersList({this.searchName});
}

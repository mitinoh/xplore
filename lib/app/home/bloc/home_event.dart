part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetLocationList extends HomeEvent {
  String? searchName;
  GetLocationList({this.searchName});
}

class GetHomeLocationList extends HomeEvent {}

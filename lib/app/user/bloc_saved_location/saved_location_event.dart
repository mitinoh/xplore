part of 'saved_location_bloc.dart';

abstract class SavedLocationEvent extends Equatable {
  const SavedLocationEvent();

  @override
  List<Object> get props => [];
}

class SavedLocationInitUserListEvent extends SavedLocationEvent {
  final String? uid;
  const SavedLocationInitUserListEvent({this.uid});
}

class SavedLocationGetUserListEvent extends SavedLocationEvent {
  final List<LocationModel> savedLocationList;
  final String? uid;
  const SavedLocationGetUserListEvent(
      {required this.savedLocationList, this.uid});

  @override
  List<Object> get props => [savedLocationList];
}

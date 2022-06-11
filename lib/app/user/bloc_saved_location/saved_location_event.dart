part of 'saved_location_bloc.dart';

abstract class SavedLocationEvent extends Equatable {
  const SavedLocationEvent();

  @override
  List<Object> get props => [];
}

class SavedLocationInitUserListEvent extends SavedLocationEvent {
  const SavedLocationInitUserListEvent();
}


class SavedLocationGetUserListEvent extends SavedLocationEvent {
  final List<LocationModel> savedLocationList;
  const SavedLocationGetUserListEvent({required this.savedLocationList});

  @override
  List<Object> get props => [savedLocationList];
}

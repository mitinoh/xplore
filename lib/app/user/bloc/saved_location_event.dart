part of 'saved_location_bloc.dart';

abstract class SavedLocationEvent extends Equatable {
  const SavedLocationEvent();

  @override
  List<Object> get props => [];
}

class GetSavedLocationList extends SavedLocationEvent {
  const GetSavedLocationList();
}

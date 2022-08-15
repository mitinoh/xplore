import 'package:xplore/model/model/location_model.dart';
import 'package:equatable/equatable.dart';

abstract class SavedLocationEvent extends Equatable {
  const SavedLocationEvent();

  @override
  List<Object> get props => [];
}

/*
class SavedLocationInitUserListEvent extends SavedLocationEvent {
  final String? uid;
  const SavedLocationInitUserListEvent({this.uid});
}
*/
class GetUserSavedLocationList extends SavedLocationEvent {
  final List<LocationModel> savedLocationList;
  final String uid;
  const GetUserSavedLocationList(
      {required this.savedLocationList, required this.uid});

  @override
  List<Object> get props => [savedLocationList];
}

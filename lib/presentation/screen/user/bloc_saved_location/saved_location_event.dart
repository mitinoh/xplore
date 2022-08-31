import 'package:xplore/data/model/location_model.dart';
import 'package:equatable/equatable.dart';

abstract class SavedLocationEvent extends Equatable {
  const SavedLocationEvent();

  @override
  List<Object> get props => [];
}

class GetUserSavedLocationList extends SavedLocationEvent {
  final List<LocationModel> savedLocationList;
  final String? uid;
  const GetUserSavedLocationList({
    this.savedLocationList = const <LocationModel>[],
    this.uid = "",
  });

  @override
  List<Object> get props => [savedLocationList];
}

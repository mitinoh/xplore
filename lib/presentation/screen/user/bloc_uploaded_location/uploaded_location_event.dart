import 'package:xplore/data/model/location_model.dart';
import 'package:equatable/equatable.dart';

abstract class UploadedLocationEvent extends Equatable {
  const UploadedLocationEvent();

  @override
  List<Object> get props => [];
}

class GetUserUploadedLocationList extends UploadedLocationEvent {
  final List<LocationModel> uploadedLocationList;
  final String? uid;
  const GetUserUploadedLocationList(
      {required this.uploadedLocationList, this.uid});

  @override
  List<Object> get props => [uploadedLocationList];
}

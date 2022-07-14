part of 'uploaded_location_bloc.dart';

abstract class UploadedLocationEvent extends Equatable {
  const UploadedLocationEvent();

  @override
  List<Object> get props => [];
}


class UploadedLocationInitUserListEvent extends UploadedLocationEvent {
  final String? uid;
  const UploadedLocationInitUserListEvent({this.uid});
}


class UploadedLocationGetUserListEvent extends UploadedLocationEvent {
  final List<LocationModel> uploadedLocationList;
  final String? uid;
  const UploadedLocationGetUserListEvent({required this.uploadedLocationList, this.uid});

  @override
  List<Object> get props => [uploadedLocationList];
}

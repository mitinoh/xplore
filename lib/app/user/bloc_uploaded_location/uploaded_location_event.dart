part of 'uploaded_location_bloc.dart';

abstract class UploadedLocationEvent extends Equatable {
  const UploadedLocationEvent();

  @override
  List<Object> get props => [];
}


class UploadedLocationInitUserListEvent extends UploadedLocationEvent {
  const UploadedLocationInitUserListEvent();
}


class UploadedLocationGetUserListEvent extends UploadedLocationEvent {
  final List<LocationModel> uploadedLocationList;
  const UploadedLocationGetUserListEvent({required this.uploadedLocationList});

  @override
  List<Object> get props => [uploadedLocationList];
}

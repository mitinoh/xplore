import 'package:xplore/data/model/location_model.dart';
import 'package:equatable/equatable.dart';

abstract class UploadedLocationState extends Equatable {
  const UploadedLocationState();

  @override
  List<Object> get props => [];
}

class UploadedLocationLoadingState extends UploadedLocationState {}

class UploadedLocationLoadedState extends UploadedLocationState {
  final List<LocationModel> uploadedLocationList;
  const UploadedLocationLoadedState(
      {this.uploadedLocationList = const <LocationModel>[]});

  @override
  List<Object> get props => [uploadedLocationList];
}

class UploadedLocationError extends UploadedLocationState {
  final String? message;
  const UploadedLocationError(this.message);
}

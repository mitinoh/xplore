import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';

@immutable
abstract class NewLocationEvent extends Equatable {
  const NewLocationEvent();

  @override
  List<Object> get props => [];
}

class CreateNewLocation extends NewLocationEvent {
  final LocationModel location;
  const CreateNewLocation({required this.location});
}

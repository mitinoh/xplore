import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';

@immutable
abstract class LocationCategoryEvent extends Equatable {
  const LocationCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetLocationCategoryList extends LocationCategoryEvent {}

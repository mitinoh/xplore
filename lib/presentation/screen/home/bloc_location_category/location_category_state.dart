import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/data/model/location_category_model.dart';

@immutable
abstract class LocationCategoryState extends Equatable {
  const LocationCategoryState();

  @override
  List<Object> get props => [];
}

class LocationCategoryLoading extends LocationCategoryState {}

class LocationCategoryLoaded extends LocationCategoryState {
  final List<LocationCategoryModel> locationCategoryList;
  const LocationCategoryLoaded(
      {this.locationCategoryList = const <LocationCategoryModel>[]});
}

class LocationCategoryError extends LocationCategoryState {
  final String? message;
  const LocationCategoryError(this.message);
}

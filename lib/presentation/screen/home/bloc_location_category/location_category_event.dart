import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LocationCategoryEvent extends Equatable {
  const LocationCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetLocationCategoryList extends LocationCategoryEvent {}

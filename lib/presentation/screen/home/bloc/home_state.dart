import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/model/model/location_model.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<LocationModel> homeList;
  const HomeLoaded({required this.homeList});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

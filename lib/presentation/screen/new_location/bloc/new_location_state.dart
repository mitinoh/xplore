import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class NewLocationState extends Equatable {
  const NewLocationState();
  @override
  List<Object> get props => [];
}

class NewLocationInitial extends NewLocationState {}

class NewLocationCreated extends NewLocationState {}

class NewLocationError extends NewLocationState {
  final String message;
  NewLocationError(this.message);
}

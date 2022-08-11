import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/model/user_model.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UpdatedUserInfo extends UserState {
  const UpdatedUserInfo();
}

class UserDataLoaded extends UserState {
  final UserModel userData;
  const UserDataLoaded({required this.userData});
  
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

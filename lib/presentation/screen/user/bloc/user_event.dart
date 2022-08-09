import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/model/api/mongoose.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserInfo extends UserEvent {
  final Map<String, dynamic> map;
  const UpdateUserInfo(this.map);
}

class GetUserData extends UserEvent {
  final String fid;
  const GetUserData({required this.fid});
}

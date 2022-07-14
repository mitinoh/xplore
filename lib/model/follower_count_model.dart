import 'package:dio/dio.dart';

class FollowerCountModel {
  int? following;
  int? followed;
  int? plannedTrip;

  FollowerCountModel({this.following, this.followed, this.plannedTrip});

  FollowerCountModel.fromJson(Map<String, dynamic> json) {
    following = json['following'];
    followed = json['followed'];
    plannedTrip = json['plannedTrip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['following'] = this.following;
    data['followed'] = this.followed;
     data['plannedTrip'] = this.plannedTrip;
    return data;
  }
}

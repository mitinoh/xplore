import 'package:dio/dio.dart';

class FollowerCountModel {
  int? following;
  int? followed;

  FollowerCountModel({this.following, this.followed});

  FollowerCountModel.fromJson(Map<String, dynamic> json) {
    following = json['following'];
    followed = json['followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['following'] = this.following;
    data['followed'] = this.followed;
    return data;
  }
}

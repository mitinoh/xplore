import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/model/user_model.dart';

class FollowerModel {
  List<FollowModel>? following;
  List<FollowModel>? followed;

  FollowerModel({this.following, this.followed});

  FollowerModel.fromJson(Map<String, dynamic> json) {
    following = json['following'] as List<FollowModel>;
    followed = json['followed'] as List<FollowModel>;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['following'] = this.following as List<FollowModel>;
    data['followed'] = this.followed as List<FollowModel>;
    return data;
  }

  FollowerModel toList(Response response) {
    List<FollowModel> _following = [];
    List<FollowModel> _followed = [];
    //  FollowerModel data = FollowerModel.fromJson(response.data);

    response.data['following'].forEach((v) {
      _following.add(FollowModel.fromJson(v));
    });
    response.data['followed'].forEach((v) {
      _followed.add(FollowModel.fromJson(v));
    });
    return FollowerModel(followed: _followed, following: _following);
  }
}

class FollowModel {
  UserModel? uid;
  bool? blocked;
  UserModel? followed;

  FollowModel({this.uid, this.blocked, this.followed});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['followed'] = this.followed;
    data['blocked'] = this.blocked;
    return data;
  }

  static FollowModel fromJson(v) {
    FollowModel data = FollowModel(
        uid: UserModel.fromJson(v['uid']),
        blocked: v['blocked'],
        followed: UserModel.fromJson(v['followed']));

    return data;
  }
}

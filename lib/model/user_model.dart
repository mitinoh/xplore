import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xplore/model/location_category_model.dart';

class UserModel {
  String? sId;
  String? name;
  String? bio;
  bool? following;
  List<LocationCategoryModel>? locationCategory;

  UserModel(
      {this.sId, this.name, this.bio, this.locationCategory, this.following});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['username'];
    bio = json['bio'];
    following = json['following'];
    if (json['locationcategory'] != null) {
      locationCategory = <LocationCategoryModel>[];
      json['locationcategory'].forEach((v) {
        locationCategory!.add(new LocationCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.name;
    data['bio'] = this.bio;
    data['following'] = this.following;
    if (this.locationCategory != null) {
      data['locationcategory'] =
          this.locationCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<UserModel> toList(Response response) {
    List<UserModel> _user = [];
    response.data.forEach((v) {
      _user.add(UserModel.fromJson(v));
    });
    return _user;
  }
}

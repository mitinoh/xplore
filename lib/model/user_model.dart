import 'package:xplore/model/location_category_model.dart';

class UserModel {
  String? sId;
  String? name;
  List<LocationCategoryModel>? locationCategory;

  UserModel({this.sId, this.name, this.locationCategory});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['username'];
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
    if (this.locationCategory != null) {
      data['locationcategory'] =
          this.locationCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

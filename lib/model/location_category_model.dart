import 'package:dio/dio.dart';

class LocationCategoryModel {
  String? iId;
  String? name;
  //int? value;

  LocationCategoryModel({this.iId, this.name});

  LocationCategoryModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    name = json['name'];
   // value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iId != null) {
      data['_id'] = iId!;
    }
    data['name'] = name;
   // data['value'] = this.value;
    return data;
  }

  List<LocationCategoryModel> toList(Response response) {
    List<LocationCategoryModel> _location = [];
    response.data.forEach((v) {
      _location.add(LocationCategoryModel.fromJson(v));
    });
    return _location;
  }
}


import 'package:dio/dio.dart';

class LocationCategory {
  String? iId;
  String? name;
  //int? value;

  LocationCategory({this.iId, this.name});

  LocationCategory.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    name = json['name'];
   // value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!;
    }
    data['name'] = this.name;
   // data['value'] = this.value;
    return data;
  }

  List<LocationCategory> toList(Response response) {
    List<LocationCategory> _location = [];
    response.data.forEach((v) {
      _location.add(LocationCategory.fromJson(v));
    });
    return _location;
  }
}


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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iId != null) {
      data['_id'] = iId!;
    }
    data['name'] = name;
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


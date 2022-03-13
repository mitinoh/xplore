import 'package:dio/dio.dart';

class LocationCategory {
  Id? iId;
  String? name;
  int? value;

  LocationCategory({this.iId, this.name, this.value});

  LocationCategory.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['name'] = this.name;
    data['value'] = this.value;
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

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}

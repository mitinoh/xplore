import 'dart:developer';

import 'package:dio/dio.dart';

import 'coordinate_model.dart';

class Location {
  String? iId;
  String? name;
  Coordinate? coordinate;
  List<int>? category;
  String? desc;
  DateTime? cdate;

  Location(
      {this.iId,
      this.name,
      this.coordinate,
      this.category,
      this.desc,
      this.cdate});

  Location.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] ?? '';
    name = json['name'] ?? '';
    coordinate = json['coordinate'] != null
        ? new Coordinate.fromJson(json['coordinate'])
        : null;
    category = json['category'] != null ? json['category'].cast<String>() : [];
    desc = json['desc'];
    cdate =
        json['cdate'] != null ? DateTime.parse(json['cdate']) : DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId;
    }
    data['name'] = this.name;
    if (this.coordinate != null) {
      data['coordinate'] = this.coordinate!.toJson();
    }
    data['category'] = this.category;
    data['desc'] = this.desc;
    if (this.cdate != null) {
      data['cdate'] = this.cdate;
    }
    return data;
  }

  List<Location> toList(Response response) {
    List<Location> _location = [];
    response.data.forEach((v) {
      _location.add(Location.fromJson(v));
    });
    return _location;
  }
}

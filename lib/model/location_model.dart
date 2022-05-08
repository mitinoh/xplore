import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/model/location_category_model.dart';

import 'coordinate_model.dart';

class Location {
  String? iId;
  String? name;
  Coordinate? coordinate;
  List<LocationCategory>? locationCategory;
  String? desc;
  DateTime? cdate;

  Location(
      {this.iId,
      this.name,
      this.coordinate,
      this.locationCategory,
      this.desc,
      this.cdate});

  Location.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] ?? '';
    name = json['name'] ?? '';
    coordinate = json['coordinate'] != null
        ? new Coordinate.fromJson(json['coordinate'])
        : null;

    if (json['locationCategory'] != null) {
      locationCategory = <LocationCategory>[];
      json['locationCategory'].forEach((v) {
        locationCategory!.add(new LocationCategory.fromJson(v));
      });
    }
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
    data['locationCategory'] = this.locationCategory;
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

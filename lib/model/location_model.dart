import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/model/location_category_model.dart';
import 'package:xplore/model/user_model.dart';

import 'coordinate_model.dart';

class Location {
  String? iId;
  String? name;
  Coordinate? coordinate;
  List<LocationCategory>? locationCategory;
  String? desc;
  String? indication;
  DateTime? cdate;
  bool? saved;
  UserModel? insertUid;

  Location(
      {this.iId,
      this.name,
      this.coordinate,
      this.locationCategory,
      this.desc,
      this.indication,
      this.cdate,
      this.saved,
      this.insertUid});

  Location.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] ?? '';
    name = json['name'] ?? '';
    coordinate = json['coordinate'] != null
        ? Coordinate.fromJson(json['coordinate'])
        : null;

    if (json['locationCategory'] != null) {
      locationCategory = <LocationCategory>[];
      json['locationCategory'].forEach((v) {
        if (v is Map<String, dynamic>)
          locationCategory!.add(LocationCategory.fromJson(v));
      });
    }
    desc = json['desc'];
    indication = json['indication'];
    cdate =
        json['cdate'] != null ? DateTime.parse(json['cdate']) : DateTime.now();

    if (json['insertUid'] != null)
      insertUid = UserModel.fromJson(json['insertUid']);

    saved = json['saved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iId != null) {
      data['_id'] = iId;
    }
    data['name'] = name;
    if (coordinate != null) {
      data['coordinate'] = coordinate!.toJson();
    }
    data['locationCategory'] = locationCategory;
    data['desc'] = desc;
    data['indication'] = indication;
    if (cdate != null) {
      data['cdate'] = cdate;
    }
    data['saved'] = saved;
    return data;
  }

  List<Location> toList(Response response) {
    List<Location> _location = [];
    response.data.forEach((v) {
      _location.add(Location.fromJson(v));
    });
    return _location;
  }

  List<Location> toSavedLocationList(Response response) {
    List<Location> _location = [];
    response.data.forEach((v) {
      _location.add(Location.fromJson(v["location"]));
    });
    return _location;
  }
}

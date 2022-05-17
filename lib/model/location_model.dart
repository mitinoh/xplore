
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
  bool? saved;

  Location(
      {this.iId,
      this.name,
      this.coordinate,
      this.locationCategory,
      this.desc,
      this.cdate,
      this.saved});

  Location.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] ?? '';
    name = json['name'] ?? '';
    coordinate = json['coordinate'] != null
        ? Coordinate.fromJson(json['coordinate'])
        : null;

    if (json['locationCategory'] != null) {
      locationCategory = <LocationCategory>[];
      json['locationCategory'].forEach((v) {
        locationCategory!.add(LocationCategory.fromJson(v));
      });
    }
    desc = json['desc'];
    cdate =
        json['cdate'] != null ? DateTime.parse(json['cdate']) : DateTime.now();

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
}

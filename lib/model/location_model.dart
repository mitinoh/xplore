import 'dart:developer';

import 'package:dio/dio.dart';

class Location {
  Id? iId;
  String? name;
  Coordinate? coordinate;
  List<int>? category;
  String? desc;
  Cdate? cdate;

  Location(
      {this.iId,
      this.name,
      this.coordinate,
      this.category,
      this.desc,
      this.cdate});

  Location.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    name = json['name'] ?? '';
    coordinate = json['coordinate'] != null
        ? new Coordinate.fromJson(json['coordinate'])
        : null;
    category = json['category'] != null ? json['category'].cast<int>() : [];
    desc = json['desc'];
    cdate = json['cdate'] != null ? new Cdate.fromJson(json['cdate']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['name'] = this.name;
    if (this.coordinate != null) {
      data['coordinate'] = this.coordinate!.toJson();
    }
    data['category'] = this.category;
    data['desc'] = this.desc;
    if (this.cdate != null) {
      data['cdate'] = this.cdate!.toJson();
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

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['\$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}

class Coordinate {
  double? lat;
  double? lng;
  double? alt;

  Coordinate({this.lat, this.lng, this.alt});

  Coordinate.fromJson(Map<String, dynamic> json) {
    lat = json['lat'].toDouble();
    lng = json['lng'].toDouble();
    lng = json['lng'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['lng'] = this.lng;
    return data;
  }
}

class Cdate {
  String? date;

  Cdate({this.date});

  Cdate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}

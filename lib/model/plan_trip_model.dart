import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/model/coordinate_model.dart';
import 'package:xplore/model/location_model.dart';

class PlanTrip {
  String? iId;
  String? fid;
  List<Trip>? trip;
  DateTime? returnDate;
  Coordinate? coordinate;
  int? distance;
  int? periodAvaiable;
  int? totDay;
  List<Object>? avoidCategory;
  List<int>? dayAvaiable;
  DateTime? goneDate;
  DateTime? cdate;

  PlanTrip(
      {this.iId,
      this.fid,
      this.trip,
      this.returnDate,
      this.coordinate,
      this.distance,
      this.periodAvaiable,
      this.totDay,
      this.avoidCategory,
      this.dayAvaiable,
      this.goneDate,
      this.cdate});

  PlanTrip.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    fid = json['fid'];
    if (json['trip'] != null) {
      trip = <Trip>[];
      json['trip'].forEach((v) {
        trip!.add(new Trip.fromJson(v));
      });
    }

    returnDate = json['returnDate'] != null
        ? DateTime.parse(json['returnDate'])
        : DateTime.now();
    goneDate = json['goneDate'] != null
        ? DateTime.parse(json['goneDate'])
        : DateTime.now();
    coordinate = json['coordinate'] != null
        ? new Coordinate.fromJson(json['coordinate'])
        : null;
    distance = json['distance'].toInt();
    periodAvaiable = json['periodAvaiable'];
    totDay = json['totDay'];

    if (json['avoidCategory'] != null) {
      avoidCategory = <Object>[]; // FIXME: Creare model apposito
      json['avoidCategory'].forEach((v) {
        avoidCategory!.add(v);
      });
    }
    /*if (json['dayAvaiable'] != null) {
      dayAvaiable = <int>[];
      json['dayAvaiable'].forEach((v) {
        dayAvaiable!.add(v);
      });
    }*/
    json['cdate'] != null ? DateTime.parse(json['cdate']) : DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId;
    }
    data['fid'] = this.fid;
    if (this.trip != null) {
      data['trip'] = this.trip!.map((v) => v.toJson()).toList();
    }
    if (this.returnDate != null) {
      data['returnDate'] = this.returnDate;
    }
    if (this.coordinate != null) {
      data['coordinate'] = this.coordinate!.toJson();
    }
    data['distance'] = this.distance;
    data['periodAvaiable'] = this.periodAvaiable;
    data['totDay'] = this.totDay;
    if (this.avoidCategory != null) {
      data['avoidCategory'] = this.avoidCategory!.map((v) => v).toList();
    }
    if (this.dayAvaiable != null) {
      data['dayAvaiable'] = this.dayAvaiable!.map((v) => v).toList();
    }
    if (this.goneDate != null) {
      data['goneDate'] = this.goneDate!;
    }
    if (this.cdate != null) {
      data['cdate'] = this.cdate;
    }
    return data;
  }

  Map<String, dynamic> toJsonPost(Map<String, dynamic> obj) {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (obj['plannedLocation'] != null) {
      data['plannedLocation'] = obj['plannedLocation']!.map((v) => v).toList();
    }
    if (obj['returnDate'] != null) {
      data['returnDate'] = obj['returnDate'];
    }
    if (obj['goneDate'] != null) {
      data['goneDate'] = obj['goneDate'];
    }

    if (obj['coordinate'] != null) {
      data['coordinate'] = obj['coordinate'];
    }
    data['tripName'] = obj['tripName'];
    data['distance'] = obj['distance'];

    if (obj['avoidCategory'] != null) {
      List<String> cat = [];

      obj['avoidCategory']!
          .map((v) => {if (v != null && v.toString().trim() != "") cat.add(v)});
      data['avoidCategory'] = cat;
    }
    return data;
  }

  List<PlanTrip> toList(Response response) {
    List<PlanTrip> _location = [];
    response.data.forEach((v) {
      _location.add(PlanTrip.fromJson(v));
    });
    return _location;
  }
}

class Date {
  String? numberLong;

  Date({this.numberLong});

  Date.fromJson(Map<String, dynamic> json) {
    numberLong = json['$numberLong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$numberLong'] = this.numberLong;
    return data;
  }
}

class Trip {
  Date? date;
  String? locationId;
  Location? location;

  Trip({this.date, this.locationId, this.location});

  Trip.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    locationId = json['locationId'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    if (this.locationId != null) {
      data['locationId'] = this.locationId!;
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

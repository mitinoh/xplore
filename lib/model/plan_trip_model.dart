import 'package:dio/dio.dart';
import 'package:xplore/model/coordinate_model.dart';
import 'package:xplore/model/location_model.dart';

class PlanTripModel {
  String? iId;
  String? fid;
  List<Trip>? trip;
  DateTime? returnDate;
  CoordinateModel? coordinate;
  int? distance;
  int? periodAvaiable;
  int? totDay;
  List<Object>? avoidCategory;
  List<int>? dayAvaiable;
  DateTime? goneDate;
  DateTime? cdate;
  String? tripName;

  PlanTripModel(
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
      this.cdate,
      this.tripName});

  PlanTripModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    fid = json['fid'];
    tripName = json['tripName'];
    if (json['trip'] != null) {
      trip = <Trip>[];
      json['trip'].forEach((v) {
        trip!.add(Trip.fromJson(v));
      });
    }

    returnDate = json['returnDate'] != null
        ? DateTime.parse(json['returnDate'])
        : DateTime.now();
    goneDate = json['goneDate'] != null
        ? DateTime.parse(json['goneDate'])
        : DateTime.now();
    coordinate = json['coordinate'] != null
        ? CoordinateModel.fromJson(json['coordinate'])
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iId != null) {
      data['_id'] = iId;
    }
    data['fid'] = fid;
    data['tripName'] = tripName;
    if (trip != null) {
      data['trip'] = trip!.map((v) => v.toJson()).toList();
    }
    if (returnDate != null) {
      data['returnDate'] = returnDate;
    }
    if (coordinate != null) {
      data['coordinate'] = coordinate!.toJson();
    }
    data['distance'] = distance;
    data['periodAvaiable'] = periodAvaiable;
    data['totDay'] = totDay;
    if (avoidCategory != null) {
      data['avoidCategory'] = avoidCategory!.map((v) => v).toList();
    }
    if (dayAvaiable != null) {
      data['dayAvaiable'] = dayAvaiable!.map((v) => v).toList();
    }
    if (goneDate != null) {
      data['goneDate'] = goneDate!;
    }
    if (cdate != null) {
      data['cdate'] = cdate;
    }
    return data;
  }

  Map<String, dynamic> toJsonPost(Map<String, dynamic> obj) {
    final Map<String, dynamic> data = <String, dynamic>{};

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

  List<PlanTripModel> toList(Response response) {
    List<PlanTripModel> _location = [];
    response.data.forEach((v) {
      _location.add(PlanTripModel.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$numberLong'] = numberLong;
    return data;
  }
}

class Trip {
  Date? date;
  String? locationId;
  LocationModel? location;

  Trip({this.date, this.locationId, this.location});

  Trip.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
    locationId = json['locationId'];
    location = json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (date != null) {
      data['date'] = date!.toJson();
    }
    if (locationId != null) {
      data['locationId'] = locationId!;
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

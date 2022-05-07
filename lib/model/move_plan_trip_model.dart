import 'dart:convert';
import 'dart:developer';

class MovePlanTrip {
  String? locationId;
  DateTime? date;

  MovePlanTrip({this.locationId, this.date});

  MovePlanTrip.fromJson(Map<String, dynamic> json) {
    locationId = json['locationId'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    String id = this.locationId ?? '';
    data['location'] = id; // 'ObjectId("$id")'
    data['date'] = this.date?.toIso8601String();
    return data;
  }
}

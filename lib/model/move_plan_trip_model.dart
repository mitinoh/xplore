import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

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
    data['locationId'] = this.locationId;
    data['date'] = this.date;
    return data;
  }

  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    String id = this.locationId ?? '';
    data['location'] = id; // 'ObjectId("$id")'
    data['date'] = this.date;
    return data;
  }
}

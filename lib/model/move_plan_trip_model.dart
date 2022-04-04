import 'dart:convert';

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

  String encode() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationId'] = this.locationId;
    data['date'] = this.date?.toIso8601String();
    return json.encode(data);
  }
}

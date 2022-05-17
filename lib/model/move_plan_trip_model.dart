
class MovePlanTrip {
  String? locationId;
  DateTime? date;

  MovePlanTrip({this.locationId, this.date});

  MovePlanTrip.fromJson(Map<String, dynamic> json) {
    locationId = json['locationId'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    String id = locationId ?? '';
    data['location'] = id; // 'ObjectId("$id")'
    data['date'] = date?.toIso8601String();
    return data;
  }
}

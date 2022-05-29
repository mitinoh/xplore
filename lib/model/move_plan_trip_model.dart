class MovePlanTripModel {
  String? locationId;
  DateTime? date;

  MovePlanTripModel({this.locationId, this.date});

  MovePlanTripModel.fromJson(Map<String, dynamic> json) {
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

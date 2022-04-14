import 'dart:convert';

class Coordinate {
  double? lat;
  double? lng;
  double? alt;

  Coordinate({this.lat, this.lng, this.alt});

  Coordinate.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] != null ? json['lat'].toDouble() : 0.0;
    lng = json['lng'] != null ? json['lng'].toDouble() : 0.0;
    alt = json['alt'] != null ? json['alt'].toDouble() : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['alt'] = this.alt;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coordinate &&
        other.lat == lat &&
        other.lng == lng &&
        other.alt == alt;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode ^ alt.hashCode;
}

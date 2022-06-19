class GeometryModel {
  String? type;
  List<double>? coordinates;


  GeometryModel({this.type, this.coordinates,});

   GeometryModel.fromJson(Map<String, dynamic> json) {
    type = json['type'] != null ? json['type'] : "Point";

     if (json['coordinates'] != null) {
      coordinates = <double>[];
      json['coordinates'].forEach((v) {
          coordinates!.add( v);
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
  /*
  double? lat;
  double? lng;
  double? alt;

  GeometryModel({this.lat, this.lng, this.alt});

  GeometryModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] != null ? json['lat'].toDouble() : 0.0;
    lng = json['lng'] != null ? json['lng'].toDouble() : 0.0;
    alt = json['alt'] != null ? json['alt'].toDouble() : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['alt'] = alt;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeometryModel &&
        other.lat == lat &&
        other.lng == lng &&
        other.alt == alt;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode ^ alt.hashCode;
  */
}

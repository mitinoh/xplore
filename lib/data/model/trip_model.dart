import 'package:json_annotation/json_annotation.dart';
import 'package:xplore/data/model/geometry_model.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/user_model.dart';

part 'trip_model.g.dart';

@JsonSerializable()
class TripModel {
  DateTime? date;
  //String? locationId;
  LocationModel? location;

  TripModel({this.date, this.location});

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripModelToJson(this);
}
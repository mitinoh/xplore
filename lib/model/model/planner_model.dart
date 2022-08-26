import 'package:json_annotation/json_annotation.dart';
import 'package:xplore/model/model/geometry_model.dart';
import 'package:xplore/model/model/location_category_model.dart';
import 'package:xplore/model/model/trip_model.dart';
import 'package:xplore/model/model/user_model.dart';

part 'planner_model.g.dart';

@JsonSerializable()
class PlannerModel {
  @JsonKey(name: '_id')
  String id;
  String? tripName;
  int? distance;
  GeometryModel? geometry;
  List<Object>? avoidCategory;
  List<TripModel>? trip;
  UserModel? uid;
  DateTime? returnDate;
  DateTime? goneDate;
  DateTime? cdate;

  PlannerModel({
    required this.id,
      this.uid,
      this.trip,
      this.returnDate,
      this.geometry,
      this.distance,
      this.avoidCategory,
      this.goneDate,
      this.cdate,
      this.tripName
  });

  factory PlannerModel.fromJson(Map<String, dynamic> json) =>
      _$PlannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlannerModelToJson(this);
}

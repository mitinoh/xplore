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
  UserModel? uid;
  List<TripModel>? trip;
  DateTime? returnDate;
  GeometryModel? geometry;
  int? distance;
  //int? periodAvaiable;
  //int? totDay;
  List<Object>? avoidCategory;
  //List<int>? dayAvaiable;
  DateTime? goneDate;
  DateTime? cdate;
  String? tripName;

  PlannerModel({
    required this.id,
      this.uid,
      this.trip,
      this.returnDate,
      this.geometry,
      this.distance,
      //this.periodAvaiable,
      //this.totDay,
      this.avoidCategory,
      //this.dayAvaiable,
      this.goneDate,
      this.cdate,
      this.tripName
  });

  factory PlannerModel.fromJson(Map<String, dynamic> json) =>
      _$PlannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlannerModelToJson(this);
}

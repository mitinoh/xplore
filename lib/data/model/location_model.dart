import 'package:json_annotation/json_annotation.dart';
import 'package:xplore/data/model/geometry_model.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/data/model/user_model.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  @JsonKey(name: '_id')
  String id;
  String? name;
  GeometryModel? geometry;
  List<LocationCategoryModel>? locationCategory;
  String? desc;
  String? indication;
  bool? saved;
  UserModel? insertUid;
  String? base64;

  LocationModel({
    required this.id,
    this.name,
    this.geometry,
    this.locationCategory,
    this.desc,
    this.indication,
    this.saved,
    this.insertUid,
    this.base64
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}

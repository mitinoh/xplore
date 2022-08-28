import 'package:json_annotation/json_annotation.dart';

part 'location_category_model.g.dart';

@JsonSerializable()
class LocationCategoryModel {
  @JsonKey(name: '_id')
  String? id;
  String? name;

  LocationCategoryModel({required this.id, this.name});

  factory LocationCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$LocationCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationCategoryModelToJson(this);
}

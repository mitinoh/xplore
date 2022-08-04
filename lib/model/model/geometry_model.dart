import 'package:json_annotation/json_annotation.dart';

part 'geometry_model.g.dart';

@JsonSerializable()
class GeometryModel {


  String? type;
  List<double>? coordinates;

  GeometryModel({required this.type, this.coordinates});

  factory GeometryModel.fromJson(Map<String, dynamic> json) =>
      _$GeometryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryModelToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      id: json['_id'] as String,
      name: json['name'] as String?,
      geometry: json['geometry'] == null
          ? null
          : GeometryModel.fromJson(json['geometry'] as Map<String, dynamic>),
      locationCategory: (json['locationCategory'] as List<dynamic>?)
          ?.map(
              (e) => LocationCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      desc: json['desc'] as String?,
      indication: json['indication'] as String?,
      saved: json['saved'] as bool?,
      insertUid: json['insertUid'] == null
          ? null
          : UserModel.fromJson(json['insertUid'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'geometry': instance.geometry,
      'locationCategory': instance.locationCategory,
      'desc': instance.desc,
      'indication': instance.indication,
      'saved': instance.saved,
      'insertUid': instance.insertUid,
    };

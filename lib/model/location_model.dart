import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:xplore/model/location_category_model.dart';
import 'package:xplore/model/user_model.dart';

import 'coordinate_model.dart';

class LocationModel {
  String? iId;
  String? name;
  GeometryModel? geometry;
  List<LocationCategoryModel>? locationCategory;
  String? desc;
  String? indication;
  DateTime? cdate;
  bool? saved;
  UserModel? insertUid;
  String? savedId;
  String? uploadId;
  LocationModel(
      {this.iId,
      this.name,
      this.geometry,
      this.locationCategory,
      this.desc,
      this.indication,
      this.cdate,
      this.saved,
      this.insertUid,
      this.savedId,
      this.uploadId});

  LocationModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] ?? '';
    name = json['name'] ?? '';
    geometry = json['geometry'] != null
        ? GeometryModel.fromJson(json['geometry'])
        : null;

    if (json['locationCategory'] != null) {
      locationCategory = <LocationCategoryModel>[];
      json['locationCategory'].forEach((v) {
        if (v is Map<String, dynamic>)
          locationCategory!.add(LocationCategoryModel.fromJson(v));
      });
    }
    desc = json['desc'];
    indication = json['indication'];
    cdate =
        json['cdate'] != null ? DateTime.parse(json['cdate']) : DateTime.now();

    if (json['insertUid'] != null)
      insertUid = UserModel.fromJson(json['insertUid']);
    if (json['saved'] != null) saved = json['saved'].length > 0;
  }

  LocationModel.fromSavedJson(Map<String, dynamic> json) {
    savedId = json['_id'] ?? '';
    iId = json['location']['_id'] ?? '';
    name = json['location']['name'] ?? '';
    geometry = json['location']['geometry'] != null
        ? GeometryModel.fromJson(json['location']['geometry'])
        : null;

    if (json['location']['locationCategory'] != null) {
      locationCategory = <LocationCategoryModel>[];
      json['location']['locationCategory'].forEach((v) {
        if (v is Map<String, dynamic>)
          locationCategory!.add(LocationCategoryModel.fromJson(v));
      });
    }
    desc = json['location']['desc'];
    indication = json['location']['indication'];
    cdate = json['location']['cdate'] != null
        ? DateTime.parse(json['location']['cdate'])
        : DateTime.now();

    if (json['location']['insertUid'] != null)
      insertUid = UserModel.fromJson(json['location']['insertUid']);
    if (json['location']['saved'] != null)
      saved = json['location']['saved'].length > 0;
    //LocationModel.fromJson(json['location']);
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iId != null) {
      data['_id'] = iId;
    }
    data['name'] = name;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    data['locationCategory'] = locationCategory;
    data['desc'] = desc;
    data['indication'] = indication;
    if (cdate != null) {
      data['cdate'] = cdate;
    }
    data['saved'] = saved;
    return data;
  }

  List<LocationModel> toList(Response response) {
    List<LocationModel> _location = [];
    response.data.forEach((v) {
      _location.add(LocationModel.fromJson(v));
    });
    return _location;
  }

  List<LocationModel> toSavedLocationList(Response response) {
    List<LocationModel> _location = [];
    response.data.forEach((v) {
      _location.add(LocationModel.fromSavedJson(v));
    });
    return _location;
  }
}

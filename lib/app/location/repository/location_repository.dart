import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/core/repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

class LocationRepository extends Repository {
  static int lastSkipIndex = 0;
  static var skip = 0;
  static var limit = 15;
  static List<String> categoryFilter = [];
  final Dio _dio = Dio();

  Future<List<Location>> fetchLocationList({required Mongoose mng}) async {
    String url = conf.locationColl + mng.getUrl();
    await setDio(_dio);
    log(url);
    Response response = await _dio.get(url);

    return Location().toList(response);
  }

  Future<void> newLocationPut({required Map<String, dynamic> map}) async {
    doPost(url: conf.newLocationColl, data: json.encode(map));
  }

  Future<void> saveUserLocationPost({required String id}) async {
       Map<String, dynamic> map = { "location": id };
    doPost(url: conf.savedLocationColl, data: json.encode(map));
  }
/*
  String getPipeline({String? searchName}) {
    List<String> mtc = [];
    if (searchName != null && searchName.trim() != "") {
      mtc.add('{ "name": {  "\$regex": "$searchName",  "\$options": "gi" } }');
    }
    if (categoryFilter.isNotEmpty) {
      mtc.add(' { "category": { "\$in" : [${categoryFilter.join(",")}]}} ');
    }
    String pipe = ""; //  {'\$limit': 1 }
    if (mtc.isNotEmpty) {
      pipe = ' {"\$match": ${mtc.join(",")} } ';
    }

    pipe =
        '{pipeline: [' + pipe + ', {"\$skip": $skip}, {"\$limit": $limit }]}';
    return pipe;
  }
*/
  Mongoose getMongoose({String? searchName}) {
    Mongoose mng = Mongoose();
    mng.limit = limit;
    mng.skip = skip;
    mng.filter = {};

    if (searchName != null && searchName.trim() != "") {
      mng.filter?.putIfAbsent("name",
          () => '*${searchName}*'); // TODO aggiungere "se parola è cpntenuta"
    }
    if (categoryFilter.isNotEmpty) {
      mng.filter
          ?.putIfAbsent("locationcategory", () => categoryFilter.join(','));
    }

    return mng;
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/core/repository.dart';
import 'package:xplore/model/location_model.dart';

class HomeRepository extends Repository {
  static var skip = 0;
  static var limit = 15;
  static List<int> categoryFilter = [];
  final Dio _dio = Dio();
  Future<List<Location>> fetchLocationList({required String body}) async {
    String url = conf.ip + conf.locationColl;
    await setDio(_dio);
    log(body);
    Response response = await _dio.post(url, data: body);
    return Location().toList(response);
  }

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

  Future<void> newLocationPut({required String body}) async {
    try {
      String url = conf.ip + conf.newLocationColl;
      await setDio(_dio);
      await _dio.put(url, data: body);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> saveUserLocationPut({required String body}) async {
    try {
      String url = conf.ip + conf.savedLocationColl;
      await setDio(_dio);
      await _dio.put(url, data: body);
    } catch (e) {
      throw Exception(e);
    }
  }
}

class NetworkError extends Error {}

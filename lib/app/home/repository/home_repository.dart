import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:xplore/core/repository.dart';
import 'package:xplore/model/location_model.dart';

class HomeRepository extends Repository {
  static List<int> categoryFilter = [];
  final Dio _dio = Dio();
  Future<List<Location>> fetchLocationList({required String body}) async {
    String url = conf.ip + conf.locationColl;
    await setDio(_dio);
    log("----");
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
    String pipe = "{}";
    if (mtc.isNotEmpty) {
      pipe = '{pipeline: [ {"\$match": ${mtc.join(",")} } ]}';
    }
    return pipe;
  }
}

class NetworkError extends Error {}

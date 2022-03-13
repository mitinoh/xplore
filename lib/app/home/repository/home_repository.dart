import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/core/repository.dart';
import 'package:xplore/model/location_model.dart';
import 'dart:convert' as convert;

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
    if (searchName != null) {
      //{pipeline:[{"\$match": {  "name": {"\$eq": " + mtc "
      mtc.add('{ "name": { "\$eq" : "$searchName" } }');
    }
    if (categoryFilter.isNotEmpty) {
      mtc.add(' { "category": { "\$in" : [${categoryFilter.join(",")}]}} ');
    }
    String pipe = "";
    if (mtc.isNotEmpty)
      pipe = '{pipeline: [ {"\$match": ${mtc.join(",")} } ]}';
    else
      pipe = '{}';
    log(pipe);
    return pipe;
  }
}

class NetworkError extends Error {}

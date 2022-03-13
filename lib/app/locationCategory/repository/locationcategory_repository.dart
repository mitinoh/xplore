import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/app/user/user_model.dart';
import 'package:xplore/core/repository.dart';
import 'package:xplore/model/locationCategory_model.dart';
import 'package:xplore/model/location_model.dart';
import 'dart:convert' as convert;

class LocationCategoryRepository extends Repository {
  final Dio _dio = Dio();

  Future<List<LocationCategory>> fetchLocationCategoryList(
      {String body = "{}"}) async {
    String url = conf.ip + conf.locationCategoryColl;
    await setDio(_dio);
    Response response = await _dio.post(url, data: body);
    return LocationCategory().toList(response);
  }
}

class NetworkError extends Error {}

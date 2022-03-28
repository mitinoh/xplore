import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/core/repository.dart';
import 'package:xplore/model/location_model.dart';

class PlanTripRepository extends Repository {
  static List<int> categoryFilter = [];
  final Dio _dio = Dio();

  Future<List<Location>> fetchLocationList({required String body}) async {
    String url = conf.ip + "planTrip";
    await setDio(_dio);
    Response response = await _dio.post(url, data: "{pipeline: [$body]}");
    log(response.toString());
    return Location().toList(response);
  }
}

class NetworkError extends Error {}

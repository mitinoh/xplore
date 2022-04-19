import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/core/repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/plan_trip_model.dart';

class PlanTripRepository extends Repository {
  final Dio _dio = Dio();

  Future<List<Location>> fetchLocationList({required String body}) async {
    String url = conf.ip + conf.planTripColl + '?plan=true';
    await setDio(_dio);
    Response response = await _dio.post(url, data: "{pipeline: [$body]}");
    return Location().toList(response);
  }

  Future<void> newPlanTripPut({required String body}) async {
    try {
      String url = conf.ip + conf.planTripColl;
      await setDio(_dio);
      Response response = await _dio.put(url, data: body);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PlanTrip>> fetchPlannedTripList({required String body}) async {
    String fid = getUserID();
    int now = DateTime.now().millisecondsSinceEpoch;
    body = """
  {
    '\$match': {
      'fid': {
        '\$eq': '$fid'
      }, 
      'returnDate': {
        '\$gte': $now
      }
    }
  }
""";
    String url = conf.ip + conf.planTripColl;
    await setDio(_dio);
    Response response = await _dio.post(url, data: "{pipeline: [$body]}");
    return PlanTrip().toList(response);
  }
}

class NetworkError extends Error {}

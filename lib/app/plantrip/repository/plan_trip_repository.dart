import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/core/repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';
import 'package:xplore/model/plan_trip_model.dart';

class PlanTripRepository extends Repository {
  final Dio _dio = Dio();

  Future<List<Location>> fetchLocationList(
      {/*required String body, */ required Mongoose mng}) async {
    String url = conf.locationColl + mng.getUrl();
    await setDio(_dio);
    Response response = await _dio.get(url);
    return Location().toList(response);
  }

  Future<void> newPlanTripPut({required Map<String, dynamic> body}) async {
    try {
      String url = conf.planTripColl;
      log(url);
      //log(PlanTrip().toJsonPost(body).toString());
      // FIXME: encode sbaglaito
      log("*****");
      log(json.encode(PlanTrip().toJsonPost(body)));
      await setDio(_dio);
      Response response =
          await _dio.post(url, data: PlanTrip().toJsonPost(body));
      log(response.toString());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PlanTrip>> fetchPlannedTripList({required String body}) async {

    String url = conf.planTripColl + '?progress=true';

    log(url);
    await setDio(_dio);
    Response response = await _dio.get(url);
    return PlanTrip().toList(response);
  }
}

class NetworkError extends Error {}

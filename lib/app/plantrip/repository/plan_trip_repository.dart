import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/http_service.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';
import 'package:xplore/model/plan_trip_model.dart';

class PlanTripRepository {
  Config conf = Config();
  HttpService httpService = HttpService();

  Future<List<LocationModel>> getLocationList(
      {required Mongoose mng}) async {
    String url = conf.locationColl + mng.getUrl();
    Response response = await httpService.request(method: Method.GET, url: url);
    return LocationModel().toList(response);
  }

  Future<void> newPlanTripPut({required Map<String, dynamic> body}) async {
    try {
      String url = conf.planTripColl;
      Response response = await httpService.request(
          method: Method.POST,
          url: url,
          params: PlanTripModel().toJsonPost(body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PlanTripModel>> getPlannedTripList() async {
    String url = conf.planTripColl + '?future=true';
    Response response = await httpService.request(method: Method.GET, url: url);
    return PlanTripModel().toList(response);
  }

  Future<List<PlanTripModel>> getCurrentPlannedTripList() async {
    String url = conf.planTripColl + '?current=true';
    Response response = await httpService.request(method: Method.GET, url: url);
    return PlanTripModel().toList(response);
  }
}

class NetworkError extends Error {}

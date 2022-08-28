import 'package:flutter/material.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/api/rest_client.dart';
import 'package:xplore/data/dio_provider.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/utils/logger.dart';

class PlannerRepository {
  final dio = DioProvider.instance();
  final DateTime now = DateUtils.dateOnly(DateTime.now());

  Future<List<LocationModel>> getUserUploadedLocation(Mongoose mng) async {
    final client = RestClient(await dio);
    return await client.getUserUploadedLocation(mng.getUrl());
  }

  Future<List<PlannerModel>> getPlannedTripList(Mongoose mng) async {
    final client = RestClient(await dio);
    Logger.info(mng.getUrl());
    return await client.getPlannedTrip(mng.getUrl());
  }

  Future<void> savePlannedTrip(PlannerModel plannedTrip) async {
    final client = RestClient(await dio);
    return await client.savePlannedTrip(plannedTrip);
  }

  Mongoose get getInProgressTripMng {
    return Mongoose(filter: [
      Filter(
        key: 'returnDate',
        operation: '>=',
        value: now.toIso8601String(),
      ),
      Filter(
        key: 'goneDate',
        operation: '<=',
        value: now.toIso8601String(),
      )
    ]);
  }

  Mongoose get getFutureTripMng {
    return Mongoose(
        filter: [Filter(key: 'goneDate', operation: '>', value: now.toIso8601String())]);
  }
}

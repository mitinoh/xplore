import 'package:dio/dio.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/http_service.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';
import 'package:xplore/model/plan_trip_model.dart';

class PlanTripRepository {
  Config conf = Config();
  HttpService httpService = HttpService();

  Future<List<Location>> getLocationList(
      {/*required String body, */ required Mongoose mng}) async {
    String url = conf.locationColl + mng.getUrl();
    Response response = await httpService.request(method: Method.GET, url: url);
    return Location().toList(response);
  }

  Future<void> newPlanTripPut({required Map<String, dynamic> body}) async {
    try {
      String url = conf.planTripColl;
      // FIXME: encode sbaglaito
      Response response = await httpService.request(
          method: Method.POST, url: url, params: PlanTrip().toJsonPost(body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PlanTrip>> fetchPlannedTripList() async {
    String url = conf.planTripColl + '?progress=true';
    Response response = await httpService.request(method: Method.GET, url: url);
    return PlanTrip().toList(response);
  }
}

class NetworkError extends Error {}

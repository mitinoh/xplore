import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/http_service.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

class UserRepository {
  Config conf = Config();
  HttpService httpService = HttpService();

  Future<List<Location>> getSavedLocationList(Mongoose mng) async {
    String url = conf.savedLocationColl + mng.getUrl();
    log(url);
    Response response = await httpService.request(method: Method.GET, url: url);
    log(response.toString());
    return Location().toSavedLocationList(response);
  }
}

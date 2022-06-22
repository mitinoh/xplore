import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/http_service.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

class HomeRepository {
  Config conf = Config();
  HttpService httpService = HttpService();
  static int lastSkipIndex = 0;
  static var skip = 0;
  static var limit = 15;
  static List<String> categoryFilter = [];

  Future<List<LocationModel>> getLocationList({required Mongoose mng}) async {
    String url = conf.locationColl + mng.getUrl();
    Response response = await httpService.request(method: Method.GET, url: url);
    log(response.data.length.toString());
    return LocationModel().toList(response);
  }

  Future<void> newLocationPost({required Map<String, dynamic> map}) async {
    Response response = await httpService.request(
        method: Method.POST,
        url: conf.newLocationColl,
        params: json.encode(map));
  }

  Future<void> saveUserLocationPost({required String id, bool? save}) async {
    if (save == false) {
      Response response = await httpService.request(
          method: Method.DELETE, url: conf.savedLocationColl + '/' + id);
    } else {
      Map<String, dynamic> map = {"location": id};
      Response response = await httpService.request(
          method: Method.POST,
          url: conf.savedLocationColl,
          params: json.encode(map));
    }
  }

  Mongoose getMongoose({String? searchName, List<String>? select}) {
    Mongoose mng = Mongoose();
    mng.filter = [];

    if (searchName != null && searchName.trim() != "") {
      // TODO Sistemare questo che non funziona
      mng.filter
          ?.add(Filter(key: "searchDoc", operation: "=", value: searchName));
    }
    if (categoryFilter.isNotEmpty) {
      mng.filter?.add(Filter(
          key: "locationCategory",
          operation: "=",
          value: categoryFilter.join(',')));
    }
    return mng;
  }
}

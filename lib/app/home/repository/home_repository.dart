import 'dart:convert';
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

  Future<List<Location>> getLocationList({required Mongoose mng}) async {
    String url = conf.locationColl + mng.getUrl();
    Response response = await httpService.request(method: Method.GET, url: url);
    return Location().toList(response);
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

  Mongoose getMongoose({String? searchName, List<String>? select }) {
    Mongoose mng = Mongoose();
    mng.limit = limit;
    mng.skip = skip;
    mng.filter = {};
    mng.select = select ?? [];

    if (searchName != null && searchName.trim() != "") {
      mng.filter?.putIfAbsent("name", () => '*$searchName*,desc=*$searchName*');
    }
    if (categoryFilter.isNotEmpty) {
      mng.filter
          ?.putIfAbsent("locationCategory", () => categoryFilter.join(','));
    }
    return mng;
  }
}

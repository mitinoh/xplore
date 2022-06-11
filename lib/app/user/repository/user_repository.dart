import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/http_service.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

class UserRepository {
  Config conf = Config();
  HttpService httpService = HttpService();

  Future<List<LocationModel>> getSavedLocationList(Mongoose mng) async {
    String url = conf.savedLocationColl + mng.getUrl();
    Response response = await httpService.request(method: Method.GET, url: url);
    return LocationModel().toSavedLocationList(response);
  }

  Future<List<LocationModel>> getUploadedLocationList(Mongoose mng) async {
    String url = conf.uploadedLocationColl + mng.getUrl();
    log(url);
    Response response = await httpService.request(method: Method.GET, url: url);
    return LocationModel().toList(response);
  }

  void updateUserInfo(Map<String, dynamic> map) async {
    String url = conf.userColl;
    Response response = await httpService.request(
        method: Method.PATCH, url: url, params: json.encode(map));
  }

  static Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userName") ?? "";
  }
}

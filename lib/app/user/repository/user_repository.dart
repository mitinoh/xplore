import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/http_service.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';
import 'package:xplore/model/user_model.dart';

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
    Response response = await httpService.request(method: Method.GET, url: url);
    return LocationModel().toList(response);
  }

  Future<List<UserModel>> getUserList(Mongoose mng) async {
    String url = conf.userColl + mng.getUrl();
    Response response = await httpService.request(method: Method.GET, url: url);
    return UserModel().toList(response);
  }
  
  Future<void> reportUser({required Map<String, dynamic> map}) async {
    Response response = await httpService.request(
        method: Method.POST,
        url: conf.userReportColl,
        params: json.encode(map));
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

  static Future<String> getUserBio() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userBio") ?? "";
  }

  static void setUserName(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", username);
  }

  static void setUserBio(String bio) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userBio", bio);
  }

  getUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // return userLocation;
  }
}

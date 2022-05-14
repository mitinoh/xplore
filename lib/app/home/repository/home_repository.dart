import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:xplore/core/repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';

class HomeRepository extends Repository {
  static int lastSkipIndex = 0;
  static var skip = 0;
  static var limit = 15;
  static List<String> categoryFilter = [];
  final Dio _dio = Dio();

  Future<List<Location>> fetchLocationList({required Mongoose mng}) async {
    String url = conf.locationColl + mng.getUrl();
    await setDio(_dio);
    Response response = await _dio.get(url);
    return Location().toList(response);
  }

  Future<void> newLocationPut({required Map<String, dynamic> map}) async {
    doPost(url: conf.newLocationColl, data: json.encode(map));
  }

  Future<void> saveUserLocationPost({required String id, bool? save}) async {
    if (save == false) {
      doDelete(url: conf.savedLocationColl + '/' + id);
    } else {
      Map<String, dynamic> map = {"location": id};
      doPost(url: conf.savedLocationColl, data: json.encode(map));
    }
  }

  Mongoose getMongoose({String? searchName}) {
    Mongoose mng = Mongoose();
    mng.limit = limit;
    mng.skip = skip;
    mng.filter = {};

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

import 'package:dio/dio.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/http_service.dart';
import 'package:xplore/model/location_category_model.dart';

class LocationCategoryRepository {
  Config conf = Config();
  HttpService httpService = HttpService();

  Future<List<LocationCategoryModel>> getLocationCategoryList(
      {String body = "{}"}) async {
    String url = conf.locationCategoryColl;
    Response response = await httpService.request(method: Method.GET, url: url);
    return LocationCategoryModel().toList(response);
  }
}

class NetworkError extends Error {}

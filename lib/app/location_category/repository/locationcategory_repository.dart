import 'package:dio/dio.dart';
import 'package:xplore/core/repository.dart';
import 'package:xplore/model/locationCategory_model.dart';

class LocationCategoryRepository extends Repository {
  final Dio _dio = Dio();

  Future<List<LocationCategory>> fetchLocationCategoryList(
      {String body = "{}"}) async {
    String url = conf.locationCategoryColl;
    await setDio(_dio);
    Response response = await _dio.post(url, data: body);
    return LocationCategory().toList(response);
  }
}

class NetworkError extends Error {}

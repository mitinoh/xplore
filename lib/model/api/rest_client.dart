import 'dart:io';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:xplore/model/model/location_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://localhost:3000/api") //107.174.186.223.nip.io
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/location")
  Future<List<LocationModel>> getHomeData();

  @PATCH("/save-location/{id}")
  @DioResponseType(ResponseType.plain)
  Future<dynamic> toggleLocationLike(@Path() String id);
}

import 'dart:io';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/model/user_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://localhost:3000/api") //107.174.186.223.nip.io
//@RestApi(baseUrl: "https://107.174.186.223.nip.io/api")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/location?_={query}")
  Future<List<LocationModel>> getHomeData(@Path("query") String? query);

  @GET("/user/fid/{fid}")
  Future<UserModel> getFidUserData(@Path("fid") String? fid);

  @PATCH("/save-location/{id}")
  @DioResponseType(ResponseType.plain)
  Future<dynamic> toggleLocationLike(@Path() String id);
}

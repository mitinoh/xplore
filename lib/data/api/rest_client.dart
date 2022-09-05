import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/data/model/report_model.dart';
import 'package:xplore/data/model/user_model.dart';

part 'rest_client.g.dart';

//@RestApi(baseUrl: "http://localhost:3000/api") //107.174.186.223.nip.io
// flutter pub run build_runner build
@RestApi(baseUrl: "https://107.174.186.223.nip.io/api")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/location?_={query}")
  @DioResponseType(ResponseType.json)
  Future<List<LocationModel>> getLocationList(@Path("query") String? query);

  @GET("/location/uploaded?_={query}")
  @DioResponseType(ResponseType.json)
  Future<List<LocationModel>> getUserUploadedLocation(@Path("query") String? query);

  @GET("/location-category")
  @DioResponseType(ResponseType.json)
  Future<List<LocationCategoryModel>> getLocationCategories();

  @GET("/save-location?_={query}")
  @DioResponseType(ResponseType.json)
  Future<List<LocationModel>> getUserSavedLocation(@Path("query") String? query);

  @PATCH("/save-location/{id}")
  @DioResponseType(ResponseType.plain)
  Future<dynamic> toggleLocationLike(@Path() String id);

  @POST("/new-location")
  @DioResponseType(ResponseType.plain)
  Future<dynamic> createNewUserLocation(@Body() LocationModel map);

  @GET("/plan-trip?_={query}")
  @DioResponseType(ResponseType.json)
  Future<List<PlannerModel>> getPlannedTrip(@Path("query") String? query);

  @POST("/plan-trip")
  @DioResponseType(ResponseType.plain)
  Future<dynamic> savePlannedTrip(@Body() PlannerModel map);

  @GET("/user?_={query}")
  @DioResponseType(ResponseType.json)
  Future<List<UserModel>> getUserList(@Path("query") String? query);

  @GET("/user/fid/{fid}")
  @DioResponseType(ResponseType.json)
  Future<UserModel> getFidUserData(@Path("fid") String? fid);

  @GET("/user/uid/{uid}")
  @DioResponseType(ResponseType.json)
  Future<UserModel> getUidUserData(@Path("uid") String? uid);

  @PATCH("/user")
  @DioResponseType(ResponseType.plain)
  Future<dynamic> updateUserData(@Body() UserModel map);

  @POST("/user")
  @DioResponseType(ResponseType.plain)
  Future<dynamic> createUser(@Body() UserModel map);

  @POST("/user-report")
  @DioResponseType(ResponseType.plain)
  Future<dynamic> reportUser(@Body() ReportModel map);

  @GET("/follower/isfollowing?uid={uid}")
  @DioResponseType(ResponseType.json)
  Future<dynamic> isFollowing(@Path("uid") String uid);

  @POST("/follower/follow/{uid}")
  @DioResponseType(ResponseType.plain)
  Future<dynamic> followUser(@Path("uid") String uid);

  @POST("/follower/unfollow/{uid}")
  @DioResponseType(ResponseType.plain)
  Future<dynamic> unfollowUser(@Path("uid") String uid);
}

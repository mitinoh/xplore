import 'package:dio/dio.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/http_service.dart';
import 'package:xplore/model/follower_count_model.dart';
import 'package:xplore/model/follower_model.dart';
import 'package:xplore/model/mongoose_model.dart';

class FollowerRepository {
  Config conf = Config();
  HttpService httpService = HttpService();

  Future<FollowerCountModel> getFollowerCount(String? uid) async {
    String url = conf.followerCountColl;
    if (uid != null) url += "/$uid";
    Response response = await httpService.request(method: Method.GET, url: url);
    return FollowerCountModel.fromJson(response.data);
  }

  Future<FollowerModel> getFollower(String? uid) async {
    String url = conf.followerColl;
    if (uid != null) url += "/$uid";
    Response response = await httpService.request(method: Method.GET, url: url);
    return FollowerModel().toList(response);
  }
}

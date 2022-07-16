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
    if (uid != null) url += "?uid=$uid";
    Response response = await httpService.request(method: Method.GET, url: url);
    return FollowerCountModel.fromJson(response.data);
  }

  Future<FollowerModel> getFollower(String? uid) async {
    String url = conf.followerListColl;
    if (uid != null) url += "?uid=$uid";
    Response response = await httpService.request(method: Method.GET, url: url);
    return FollowerModel().toList(response);
  }

  Future<void> followUser(String uid, bool follow) async {
    String url = conf.followerColl + '/';
    url += follow ? 'follow' : 'unfollow';
    url += '/' + uid;
    Response response =
        await httpService.request(method: Method.POST, url: url);
  }

  Future<bool> isFollowing(String uid) async {
    String url = conf.followerColl + '/isfollowing';
    url += '?uid=$uid';
    Response response = await httpService.request(method: Method.GET, url: url);
    return response.data == "true";
  }
}

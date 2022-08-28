import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/api/rest_client.dart';
import 'package:xplore/data/dio_provider.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/user_model.dart';

class FollowerRepository {
  //static int lastSkipIndex = 0;
  //static var skip = 0;
  //static var limit = 15;

  final dio = DioProvider.instance();
  Future<UserModel> getUserData(String fid) async {
    final client = RestClient(await dio);
    return await client.getFidUserData(fid);
  }

  Future<List<UserModel>> getUserList(Mongoose mng) async {
    final client = RestClient(await dio);
    return await client.getUserList(mng.getUrl());
  }

  Future<List<LocationModel>> getUserSavedLocation(Mongoose mng) async {
    final client = RestClient(await dio);
    return await client.getUserSavedLocation(mng.getUrl());
  }

  Future<List<LocationModel>> getUserUploadedLocation(Mongoose mng) async {
    final client = RestClient(await dio);
    return await client.getUserUploadedLocation(mng.getUrl());
  }

  Future<dynamic> updateUserData(UserModel userData) async {
    final client = RestClient(await dio);
    return await client.updateUserData(userData);
  }

  Future<bool> isFollowing(String uid) async {
    final client = RestClient(await dio);
    return (await client.isFollowing(uid) == "true");
  }

  Future<dynamic> toggleFollow(String uid, bool following) async {
    final client = RestClient(await dio);
    if (following)
      return (await client.unfollowUser(uid));
    else
      return (await client.followUser(uid));
  }
}

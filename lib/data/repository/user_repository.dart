import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/api/rest_client.dart';
import 'package:xplore/data/dio_provider.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/user_model.dart';

class UserRepository {
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

  Mongoose getMongoose({String? searchName}) {
    Mongoose mng = Mongoose(filter: []);

    mng.filter?.add(Filter(
      key: "username",
      operation: "=",
      value: '/${searchName?.substring(1) ?? ""}/',
    ));

    return mng;
  }
}

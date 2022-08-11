import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/api/rest_client.dart';
import 'package:xplore/model/dio_provider.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/model/user_model.dart';

class UserRepository {
  //static int lastSkipIndex = 0;
  //static var skip = 0;
  //static var limit = 15;

  final dio = DioProvider.instance();
  Future<UserModel> getUserData(String fid) async {
    final client = RestClient(await dio);
    return await client.getFidUserData(fid);
  }

  Future<List<LocationModel>> getUserSavedLocation(Mongoose mng) async {
    final client = RestClient(await dio);
    return await client.getUserSavedLocation(mng.getUrl());
  }
  Future<List<LocationModel>> getUserUploadedLocation(Mongoose mng) async {
    final client = RestClient(await dio);
    return await client.getUserUploadedLocation(mng.getUrl());
  }
}

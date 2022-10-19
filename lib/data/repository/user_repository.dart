import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/api/rest_client.dart';
import 'package:xplore/data/dio_provider.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xplore/presentation/screen/user/bloc_saved_location/saved_location_event.dart';
import 'package:xplore/presentation/screen/user/bloc_uploaded_location/uploaded_location_event.dart';

class UserRepository {
  final dio = DioProvider.instance();

  Future<dynamic> getUserData(String fid) async {
    final client = RestClient(await dio);
    return await client.getFidUserData(fid);
  }

  Future<UserModel> getFidUserData(String fid) async {
    final client = RestClient(await dio);
    return await client.getFidUserData(fid);
  }

  Future<UserModel> getUidUserData(String uid) async {
    final client = RestClient(await dio);
    return await client.getUidUserData(uid);
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

  Future<dynamic> createNewUser(UserModel userData) async {
    final client = RestClient(await DioProvider.instance());
    return await client.createUser(userData);
  }

  Future<bool> isUserNameAvaiable(String username) async {
    Mongoose mng =
        Mongoose(filter: [Filter(key: 'username', operation: '=', value: username)]);
    final client = RestClient(await dio);
    return (await client.getUserList(mng.getUrl())).length == 0;
  }

  Future<Position> getUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Mongoose getMongooseSingleUser({String? searchName}) {
    Mongoose mng = Mongoose(filter: []);

    mng.filter?.add(Filter(
      key: "username",
      operation: "=",
      value: '/${searchName?.substring(1) ?? ""}/',
    ));

    return mng;
  }

  Mongoose getMongooseSavedLocation({required GetUserSavedLocationList event}) {
    List<String> excludeId = [];

    event.savedLocationList.forEach((location) => excludeId.add(location.id ?? ''));
    return _getMongoseSULocation(uid: event.uid, excludeId: excludeId);
  }

  Mongoose getMongooseUploadedLocation({required GetUserUploadedLocationList event}) {
    List<String> excludeId = [];
    event.uploadedLocationList.forEach((location) => excludeId.add(location.id ?? ''));
    return _getMongoseSULocation(uid: event.uid, excludeId: excludeId);
  }

  _getMongoseSULocation({String? uid = "", List<String> excludeId = const []}) {
    return Mongoose(filter: [
      Filter(key: 'uid', operation: '=', value: uid),
      Filter(key: '_id', operation: '!=', value: excludeId.join(','))
    ]);
  }
}

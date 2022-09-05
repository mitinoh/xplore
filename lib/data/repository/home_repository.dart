import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/api/rest_client.dart';
import 'package:xplore/data/dio_provider.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';

class HomeRepository {
  final dio = DioProvider.instance();

  Future<List<LocationModel>> getLocationList(Mongoose mng) async {
    final client = RestClient(await dio);
    return await client.getLocationList(mng.getUrl());
  }

  Future<dynamic> toggleLocationLike(LocationModel location) async {
    final client = RestClient(await dio);
    return await client.toggleLocationLike(location.id ?? '');
  }

  Future<dynamic> createNewLocation(LocationModel location) async {
    final client = RestClient(await dio);
    return await client.createNewUserLocation(location);
  }

  void navigateToLocation(double latitude, double longitude) async {
    final Uri _url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not open the map.';
    }
  }

  Mongoose getMongoose(
      {String? searchName, List<String>? categoryList, List<String>? select}) {
    Mongoose mng = Mongoose();
    mng.filter = [];

    if (searchName != null && searchName.trim() != "") {
      mng.filter?.add(Filter(
        key: "searchDoc",
        operation: "=",
        value: searchName,
      ));
    }

    if (categoryList != null && categoryList.isNotEmpty) {
      mng.filter?.add(Filter(
        key: "locationCategory",
        operation: "=",
        value: categoryList.join(','),
      ));
    }

    return mng;
  }

  Mongoose getMapMongoose(
      MapPosition currentMapPosition, List<LocationModel> listLocations) {
    Mongoose mng = Mongoose(filter: []);
    List<String?> idToAVoid = [];
    listLocations.forEach((m) => idToAVoid.add(m.id));

    if (idToAVoid.isNotEmpty) {
      mng.filter?.add(Filter(key: "_id", operation: "!=", value: idToAVoid.join(',')));
    }

    mng.filter?.add(Filter(
        key: "latitude",
        operation: "=",
        value: (currentMapPosition.center?.latitude ?? 0).toString()));
    mng.filter?.add(Filter(
        key: "longitude",
        operation: "=",
        value: (currentMapPosition.center?.longitude ?? 0).toString()));
    mng.filter?.add(Filter(
        key: "zoom", operation: "=", value: (currentMapPosition.zoom ?? 10).toString()));
    return mng;
  }
}

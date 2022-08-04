import 'package:xplore/model/api/rest_client.dart';
import 'package:xplore/model/dio_provider.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeRepository {
  //static int lastSkipIndex = 0;
  //static var skip = 0;
  //static var limit = 15;
  //static List<String> categoryFilter = [];
  final dio = DioProvider.instance();

  Future<List<LocationModel>> getHomeData() async {
    final client = RestClient(await dio);
    return await client.getHomeData();
  }

  Future<dynamic> toggleLocationLike(LocationModel location) async {
    final client = RestClient(await dio);
    return await client.toggleLocationLike(location.id);
  }

  void navigateToLocation(double latitude, double longitude) async {
    final Uri _url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not open the map.';
    }
  }
}

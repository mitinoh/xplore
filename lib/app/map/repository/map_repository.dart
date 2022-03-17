
import 'package:url_launcher/url_launcher.dart';
import 'package:xplore/app/location/repository/home_repository.dart';

class MapRepository extends HomeRepository {


  String getPipelineMap({double? x, double? y}) {
    List<String> mtc = [];
    String pipe = "{}"; //  {'\$limit': 1 }
    if (mtc.isNotEmpty) {
      pipe = '{pipeline: [ {"\$match": ${mtc.join(",")} } ]}';
    }
    return pipe;
  }
  
    Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
  
}

class NetworkError extends Error {}
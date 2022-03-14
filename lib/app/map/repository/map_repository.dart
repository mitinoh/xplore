
import 'package:xplore/app/home/repository/home_repository.dart';

class MapRepository extends HomeRepository {


  String getPipelineMap({double? x, double? y}) {
    List<String> mtc = [];
    String pipe = "{}"; //  {'\$limit': 1 }
    if (mtc.isNotEmpty) {
      pipe = '{pipeline: [ {"\$match": ${mtc.join(",")} } ]}';
    }
    return pipe;
  }
  
}

class NetworkError extends Error {}
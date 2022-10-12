import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/data/model/user_model.dart';

class Img {
  static String basePath = 'https://107.174.186.223.nip.io/asset';

  static String getUserUrl(UserModel? user) {
    return (user != null) ? "${basePath}/user/${user.id}.jpg" : 'defaultImage';
  }

  static String getLocationUrl(LocationModel? location) {
    return (location != null)
        ? "${basePath}/location/${location.id}.jpg"
        : 'defaultImage';
  }

  static String getplannedTripUrl(PlannerModel planner) {
    return "${basePath}/planner/${planner.id}.jpg";
  }
}

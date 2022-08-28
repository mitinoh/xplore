import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/data/model/user_model.dart';

class Img {
  static String basePath = 'https://107.174.186.223.nip.io/img';

  static String getUserUrl(UserModel user) {
    return "${basePath}/user/${user.id}.jpg";
  }

  static String getLocationUrl(LocationModel location) {
    return "${basePath}/location/${location.id}.jpg";
  }

  static String getplannedTripUrl(PlannerModel planner) {
    return "${basePath}/planner/${planner.id}.jpg";
  }
}

class Config {
  /// localhost for ios emulator
  /// 10.0.0.2 for android emulator
  String address = "localhost";
  String port = "8080";
  String appName = "xplore";
  String imageFolder = "images";

  String get ip {
    return 'http://${address}:${port}/${appName}/';
  }

  String get urlImages {
    return '${ip}${imageFolder}/';
  }

  String get userColl {
    return ip + "user";
  }

  String get locationColl {
    return ip + "location";
  }

  String get newLocationColl {
    return ip + "newLocation";
  }

  String get locationCategoryColl {
    return ip + "locationCategory";
  }

  String get rateLocationColl {
    return ip + "rateLocation";
  }

  String get savedLocationColl {
    return ip + "savedLocation";
  }

  String get visitedLocationColl {
    return ip + "visitedLocation";
  }

  String get badgeColl {
    return ip + "badge";
  }

  String get planTripColl {
    return ip + "planTrip";
  }

  String get locationImage {
    return urlImages + "location/";
  }
}

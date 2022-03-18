class Config {
  /// localhost for ios emulator
  /// 10.0.0.2 for android emulator
  String address = "localhost";
  String port = "8080";
  String appName = "xplore";
  String get ip {
    return 'http://${address}:${port}/${appName}/';
  }

  String get userColl {
    return "user";
  }

  String get locationColl {
    return "location";
  }

    String get newLocationColl {
    return "newLocation";
  }

  String get locationCategoryColl {
    return "locationCategory";
  }

  String get rateLocationColl {
    return "rateLocation";
  }

  String get savedLocationColl {
    return "savedLocation";
  }

  String get visitedLocationColl {
    return "visitedLocation";
  }

  String get badgeColl {
    return "badge";
  }
}

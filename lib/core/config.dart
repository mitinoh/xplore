import 'dart:developer';

class Config {
  /// localhost for ios emulator
  /// 10.0.0.2 for android emulator
  String address = "localhost";
  String port = "3000";
  String appName = "api";
  String imageFolder = "asset";

  String get ip {
    return 'http://$address:$port/$appName/';
  }

  String get urlFolderImages {
    return 'http://$address:$port/$imageFolder/'; 
  }

  String getLocationImageUrl(String id) {
    return locationImage + id + '.jpg';
  }

  String get userColl {
    return ip + "user";
  }

  String get locationColl {
    return ip + "location";
  }

  String get newLocationColl {
    return ip + "new-location";
  }

  String get locationCategoryColl {
    return ip + "location-category";
  }

  String get rateLocationColl {
    return ip + "rate-location";
  }

  String get savedLocationColl {
    return ip + "save-location";
  }

  String get visitedLocationColl {
    return ip + "visit-location";
  }

  String get badgeColl {
    return ip + "badge";
  }

  String get planTripColl {
    return ip + "plan-trip";
  }

  String get locationImage {
    return urlFolderImages + "location/";
  }
}

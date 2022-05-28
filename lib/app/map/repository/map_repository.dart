import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as lc;
import 'package:url_launcher/url_launcher.dart';
import 'package:xplore/app/home/repository/home_repository.dart';

class MapRepository extends HomeRepository {
  late bool _serviceEnabled;
  late lc.PermissionStatus _permissionGranted;
  lc.LocationData? _userLocation;

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  _getUserLocation() async {
    Position userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    log(userLocation.toString());
    return userLocation;
  }

  Future<lc.LocationData?> getUserLocation() async {
    lc.Location location = lc.Location();

    // Check if location service is enable
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return _userLocation;
        }
      }

      // Check if permission is granted
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == lc.PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != lc.PermissionStatus.granted) {
          return _userLocation;
        }
      }

      final _locationData = await location.getLocation();
      _userLocation = _locationData;
      return _userLocation;
    } catch (e) {
      return _userLocation;
    }

    /*setState(() {
      _userLocation = _locationData;
    });
    */
  }
}

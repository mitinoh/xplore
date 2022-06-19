import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapLayout extends StatelessWidget {
  MapLayout(
      {Key? key,
      required this.markers,
      //required this.mapBloc,
      required this.userLoc,
      required this.context})
      : super(key: key);
  //final MapBloc mapBloc;
  final List<Marker> markers;
  final Position? userLoc;
  final BuildContext context;

  late MapPosition currentMapPosition;

  loadMoreLocation() {
    //context.read<PlantripBloc>().add(PlanTripChangeQuestionEvent(increment: true));
    // TODO: aggiungere locations facendo chiamata
    if (currentMapPosition.zoom! > 14) print(currentMapPosition.center);
  }

  void startTimer() {}

  @override
  Widget build(context) {
    RestartableTimer _timer = RestartableTimer(
      const Duration(seconds: 1),
      () {
        loadMoreLocation();
      },
    );
    return FlutterMap(
      options: MapOptions(
        onPositionChanged: ((position, hasGesture) {
          _timer.reset();
          currentMapPosition = position;
        }),
        center: LatLng(
            userLoc?.latitude ?? 41.902782, userLoc?.longitude ?? 12.496366),
        zoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
          minZoom: 1,
          maxZoom: 20,
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: markers,
        ),
      ],
    );
  }
}

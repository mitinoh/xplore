import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore/app/map/bloc/map_bloc.dart';
import 'package:location/location.dart' as lc;

class MapLayout extends StatelessWidget {
  const MapLayout(
      {Key? key,
      required this.markers,
      required this.mapBloc,
      required this.userLoc})
      : super(key: key);
  final MapBloc mapBloc;
  final List<Marker> markers;
  final lc.LocationData? userLoc;
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(
            userLoc?.latitude ?? 41.902782, userLoc?.longitude ?? 12.496366),
        zoom: 5.0,
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

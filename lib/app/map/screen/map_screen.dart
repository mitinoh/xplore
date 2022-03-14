import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore/app/map/bloc/map_bloc.dart';
import 'package:xplore/app/map/widget/widget_map.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapBloc _mapBloc = MapBloc();

  @override
  void initState() {
    _mapBloc.add(GetLocationList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MapContainer(
      mapBloc: _mapBloc,
    );
  }
}

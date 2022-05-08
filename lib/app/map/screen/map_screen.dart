import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
    super.initState();
    _mapBloc.add(GetLocationList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: MapContainer(
                mapBloc: _mapBloc,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

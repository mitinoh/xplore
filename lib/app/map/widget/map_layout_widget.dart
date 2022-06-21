import 'dart:developer';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore/app/map/bloc_map/map_bloc.dart';
import 'package:xplore/app/map/widget/marker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/core/widgets/detail_location_modal.dart';
import 'package:xplore/model/location_model.dart';

class MapLayout extends StatefulWidget {
  MapLayout(
      {Key? key,
      required this.userLoc,
      required this.context,
      required this.mapLocation})
      : super(key: key);

  final Position? userLoc;
  final BuildContext context;
  final List<LocationModel> mapLocation;

  MapPosition currentMapPosition = MapPosition();

  @override
  State<MapLayout> createState() => _MapLayoutState();
}

class _MapLayoutState extends State<MapLayout> {
  List<Marker> markers = [];
  @override
  Widget build(BuildContext context) {
    RestartableTimer _timer = RestartableTimer(
      const Duration(seconds: 1),
      () {
        loadMoreLocation();
      },
    );

    return BlocProvider.value(
        value: BlocProvider.of<MapBloc>(context),
        child: BlocListener<MapBloc, MapState>(listener: (context, state) {
          if (state is MapLocationLoadedState) {
            setState(() {
              getMapMarker(state.mapLocation, context);
            });
            //getMapMarker(state.mapLocation, context);
          }
        }, child: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
          return FlutterMap(
              options: MapOptions(
                onPositionChanged: ((position, hasGesture) {
                  _timer.reset();
                  widget.currentMapPosition = position;
                }),
                center: LatLng(widget.userLoc?.latitude ?? 41.902782,
                    widget.userLoc?.longitude ?? 12.496366),
                zoom: 15.0,
              ),
              layers: [
                TileLayerOptions(
                  minZoom: 1,
                  maxZoom: 20,
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: markers,
                ),
              ]);
        })));
    /*
            child: FlutterMap(
              options: MapOptions(
                onPositionChanged: ((position, hasGesture) {
                  _timer.reset();
                  widget.currentMapPosition = position;
                }),
                center: LatLng(widget.userLoc?.latitude ?? 41.902782,
                    widget.userLoc?.longitude ?? 12.496366),
                zoom: 15.0,
              ),
              layers: [
                TileLayerOptions(
                  minZoom: 1,
                  maxZoom: 20,
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: markers,
                ),
              ],
            )));
  */
  }

  loadMoreLocation() {
    //context.read<PlantripBloc>().add(PlanTripChangeQuestionEvent(increment: true));
    if (widget.currentMapPosition.zoom != null &&
        widget.currentMapPosition.zoom! > 7) {
      context.read<MapBloc>().add(MapGetLocationListEvent(
          latitude: widget.currentMapPosition.center?.latitude ?? 0,
          longitude: widget.currentMapPosition.center?.longitude ?? 0,
          zoom: widget.currentMapPosition.zoom ?? 10,
          mapLocationList: widget.mapLocation));
    }
  }

  void getMapMarker(List<LocationModel> mapModel, BuildContext context) {
    List<Marker> _markers = [];
    for (LocationModel loc in mapModel) {
      _markers.add(Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(loc.geometry?.coordinates?[1] ?? 0.0,
            loc.geometry?.coordinates?[0] ?? 0.0),
        builder: (ctx) => GestureDetector(
            onTap: () {
              locationDetailModal(context, loc);
            },
            child: const MarkerWidget()),
      ));
    }

    setState(() {
      markers = _markers;
    });
    // return _markers;
  }

  void locationDetailModal(BuildContext context, LocationModel loc) {
    DetailLocationModal(loc: loc).show(context);
  }
}

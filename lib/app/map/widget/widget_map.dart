import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore/app/map/bloc/map_bloc.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/location_model.dart';
import 'package:location/location.dart' as lc;

class MapContainer extends StatelessWidget {
  const MapContainer({Key? key, required this.mapBloc}) : super(key: key);
  final MapBloc mapBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => mapBloc,
      child: BlocListener<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is MapLoaded) {
              return MapLayout(
                markers: getMapMarker(state.mapModel, context),
                mapBloc: mapBloc,
                userLoc: state.loc,
              );
            } else if (state is MapError) {
              return Container(child: Text("error"));
            } else {
              log(state.toString());
              return LoadingIndicator();
            }
          },
        ),
      ),
    );
  }

  List<Marker> getMapMarker(List<Location> mapModel, BuildContext context) {
    List<Marker> _markers = [];
    for (Location loc in mapModel) {
      _markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(loc.coordinate?.lat ?? 0.0, loc.coordinate?.lng ?? 0.0),
        builder: (ctx) => GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                  useRootNavigator: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 500,
                      child: Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                mapBloc.add(OpeningExternalMap(
                                    loc.coordinate?.lat ?? 0.0,
                                    loc.coordinate?.lng ?? 0.0));
                              },
                              child: Text("open google maps")),
                          Text(loc.name ?? ''),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              width: 500.0,
              padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
              color: Colors.green,
              child: Column(children: const [
                Text("Ableitungen"),
              ]),
            )),
      ));
    }
    return _markers;
  }
}

class LocationBottomsheet extends StatelessWidget {
  LocationBottomsheet({Key? key, required this.location});
  final Location location;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () {
          showModalBottomSheet<void>(
              useRootNavigator: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: Text(location.name ?? ''),
                );
              });
          // _homeBloc.add(SetFilterLocationList(amount: "string"));
        },
        icon: const Icon(Icons.menu),
      ),
    );
  }
}

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
        //LatLng(41.902782, 12.496366),
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

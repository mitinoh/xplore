import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/detail_location_modal.dart';
import 'package:xplore/presentation/screen/map/bloc_map/bloc.dart';
import 'package:xplore/presentation/screen/map/widget/wg_marker.dart';

class MapLayout extends StatefulWidget {
  const MapLayout({
    Key? key,
    required this.userPosition,
  }) : super(key: key);

  final Position? userPosition;

  @override
  State<MapLayout> createState() => _MapLayoutState();
}

class _MapLayoutState extends State<MapLayout> {
  List<Marker> markers = [];
  MapPosition currentMapPosition = MapPosition();
  bool execute = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<MapBloc>(context),
        child: BlocListener<MapBloc, MapState>(listener: (context, state) {
          if (state is MapLocationLoaded) {
            setState(() {
              _getMapMarker(state.locationList);
              execute = true;
            });
          }
        }, child: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
          return _buildFlutterMap();
        })));
  }

  FlutterMap _buildFlutterMap() => FlutterMap(
          options: MapOptions(
            onPositionChanged: ((position, hasGesture) {
              currentMapPosition = position;
              _loadMoreLocation();
            }),
            center: LatLng(widget.userPosition?.latitude ?? 41.902782,
                widget.userPosition?.longitude ?? 12.496366),
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
          ]);

  void _loadMoreLocation() {
    if (execute) {
      execute = false;
      if (currentMapPosition.zoom != null && currentMapPosition.zoom! > 7) {
        BlocProvider.of<MapBloc>(context)
          ..add(MapGetLocationList(currentMapPosition: currentMapPosition));
      }
      _resetCounter();
    }
  }

  void _resetCounter() async {
    await Future.delayed(Duration(seconds: 3));
    execute = true;
  }

  void _getMapMarker(List<LocationModel> locationList) {
    List<Marker> _markers = [];
    for (LocationModel location in locationList) {
      _markers.add(Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(location.geometry?.coordinates?[1] ?? 0.0,
            location.geometry?.coordinates?[0] ?? 0.0),
        builder: (context) => GestureDetector(
            onTap: () {
              _buildlocationDetailModalBottomSheet(location);
            },
            child: const MarkerWidget()),
      ));
    }
    setState(() {
      markers = _markers;
    });
  }

  void _buildlocationDetailModalBottomSheet(LocationModel location) {
    DetailLocationModal(loc: location).show(context);
  }
}

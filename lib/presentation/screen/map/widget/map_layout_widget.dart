
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/detail_location_modal.dart';
import 'package:xplore/presentation/screen/map/bloc_map/bloc.dart';
import 'package:xplore/presentation/screen/map/widget/marker.dart';

class MapLayout extends StatefulWidget {
  MapLayout({
    Key? key,
    required this.userPosition,
  }) : super(key: key);

  final Position? userPosition;

  MapPosition currentMapPosition = MapPosition();

  @override
  State<MapLayout> createState() => _MapLayoutState();
}

class _MapLayoutState extends State<MapLayout> {
  List<Marker> markers = [];

  Mongoose mng = Mongoose(filter: []);
  bool execute = true;
  @override
  void initState() {
    mng.filter?.add(Filter(
        key: "latitude",
        operation: "=",
        value: (widget.userPosition?.latitude).toString()));
    mng.filter?.add(Filter(
        key: "longitude",
        operation: "=",
        value: (widget.userPosition?.longitude).toString()));
    mng.filter?.add(Filter(key: "zoom", operation: "=", value: (15).toString()));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<MapBloc>(context),
        child: BlocListener<MapBloc, MapState>(listener: (context, state) {
          if (state is MapLocationLoaded) {
            setState(() {
              getMapMarker(state.locationList);
              execute = true;
            });
          }
        }, child: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
          return FlutterMap(
              options: MapOptions(
                onPositionChanged: ((position, hasGesture) {
                  // _timer?.reset();
                  widget.currentMapPosition = position;
                  loadMoreLocation();
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
        })));
  }

  loadMoreLocation() {
    if (execute) {
      execute = false;
      if (widget.currentMapPosition.zoom != null && widget.currentMapPosition.zoom! > 7) {
        Mongoose mng = Mongoose(filter: []);
        mng.filter?.add(Filter(
            key: "latitude",
            operation: "=",
            value: (widget.currentMapPosition.center?.latitude ?? 0).toString()));
        mng.filter?.add(Filter(
            key: "longitude",
            operation: "=",
            value: (widget.currentMapPosition.center?.longitude ?? 0).toString()));
        mng.filter?.add(Filter(
            key: "zoom",
            operation: "=",
            value: (widget.currentMapPosition.zoom ?? 10).toString()));

        List<LocationModel> locations = [];
        final st = context.read<MapBloc>().state;
        if (st is MapLocationLoaded) {
          locations = st.locationList;
        }

        context
            .read<MapBloc>()
            .add(MapGetLocationList(mongoose: mng, listLocations: locations));

      }
      resetCounter();
    }
  }

  resetCounter() async {
    await Future.delayed(Duration(seconds: 3));

    execute = true;
  }

  void getMapMarker(List<LocationModel> mapModel) {
    List<Marker> _markers = [];
    for (LocationModel loc in mapModel) {
      _markers.add(Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(
            loc.geometry?.coordinates?[1] ?? 0.0, loc.geometry?.coordinates?[0] ?? 0.0),
        builder: (ctx) => GestureDetector(
            onTap: () {
              locationDetailModal( loc);
            },
            child: const MarkerWidget()),
      ));
    }

    setState(() {
      markers = _markers;
    });
    // return _markers;
  }

  void locationDetailModal( LocationModel loc) {
     DetailLocationModal(loc: loc).show(context);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore/app/map/bloc/map_bloc.dart';
import 'package:xplore/app/map/widget/map_layout_widget.dart';
import 'package:xplore/core/widget/snackbar_message.dart';
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
             SnackBarMessage.show(context, state.message ?? '');
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
              return const Text("error");
            } else {
              return const LoadingIndicator();
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
              locationDetailModal(context, loc);
            },
            child: Container(
              width: 500.0,
              padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
              color: Colors.green,
              child: Column(children: const [
                Text("Ableitungen"),
              ]),
            )),
      ));
    }
    return _markers;
  }

  Future<void> locationDetailModal(BuildContext context, Location loc) {
    return showModalBottomSheet<void>(
                useRootNavigator: true,
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 500,
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              mapBloc.add(OpeningExternalMap(
                                  loc.coordinate?.lat ?? 0.0,
                                  loc.coordinate?.lng ?? 0.0));
                            },
                            child: const Text("open google maps")),
                        Text(loc.name ?? ''),
                      ],
                    ),
                  );
                });
  }
}
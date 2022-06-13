import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore/app/map/bloc_map/map_bloc.dart';
import 'package:xplore/app/map/widget/map_layout_widget.dart';
import 'package:xplore/app/map/widget/marker.dart';
import 'package:xplore/app/user/user_location_bloc/user_location_bloc.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/widgets/detail_location_modal.dart';
import 'package:xplore/core/widgets/snackbar_message.dart';
import 'package:xplore/core/widgets/widget_core.dart';
import 'package:xplore/model/location_model.dart';

class MapContainer extends StatelessWidget {
  MapContainer({Key? key, required this.context, required this.userPosition}) : super(key: key);
  BuildContext context;
  Position userPosition;
  @override
  Widget build( context) {
    return BlocProvider(
      create: (_) => MapBloc()..add(MapGetLocationInitEvent()),
      child: BlocListener<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapError) {
            SnackBarMessage.show(context, state.message ?? '');
          }
        },
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is MapLocationLoadedState) {
              return MapLayout(
                markers: getMapMarker(state.mapLocation, context),
                userLoc: userPosition,
                context: context,
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

  List<Marker> getMapMarker(
      List<LocationModel> mapModel, BuildContext context) {
    List<Marker> _markers = [];
    for (LocationModel loc in mapModel) {
      _markers.add(Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(loc.coordinate?.lat ?? 0.0, loc.coordinate?.lng ?? 0.0),
        builder: (ctx) => GestureDetector(
            onTap: () {
              locationDetailModal(context, loc);
            },
            child: const MarkerWidget()),
      ));
    }
    return _markers;
  }

  void locationDetailModal(BuildContext context, LocationModel loc) {
    DetailLocationModal(loc: loc).show(context);
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore/app/map/bloc/map_bloc.dart';
import 'package:xplore/app/map/widget/map_layout_widget.dart';
import 'package:xplore/app/map/widget/marker.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/widget/detail_location_modal.dart';
import 'package:xplore/core/widget/snackbar_message.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/location_model.dart';

class MapContainer extends StatelessWidget {
  MapContainer({Key? key, required this.mapBloc}) : super(key: key);
  final MapBloc mapBloc;

  Config conf = Config();
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
        width: 55.0,
        height: 55.0,
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

  void locationDetailModal(BuildContext context, Location loc) {

    DetailLocationModal(loc: loc, mapBloc: mapBloc).show(context);
  }
}

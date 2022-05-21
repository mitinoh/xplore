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
import 'package:xplore/core/widget/snackbar_message.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/location_model.dart';

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

  Future<void> locationDetailModal(BuildContext context, Location loc) {
    var mediaQuery = MediaQuery.of(context);
    return showModalBottomSheet<void>(
        //useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Color(0xffF6F6FC),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            height: mediaQuery.size.height * 0.6,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: UIColors.blue,
                          backgroundImage: const NetworkImage(
                              'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'mite.g'.toLowerCase(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black)),
                                TextSpan(
                                    text: ' LV. 4',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: UIColors.blue))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Iconsax.discover_1),
                        ),
                        Icon(Iconsax.heart)
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: RichText(
                                textScaleFactor: 1,
                                text: TextSpan(
                                    text: "Il colosseo di roma",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text:
                                              " - lorem ipsum is simply dummy text of the printing and typesetting industry. Versione app 1.0.1",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey)),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(loc.name ?? '',
                                overflow: TextOverflow.visible,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 30),
                        ClipRRect(
                          child: Image.network(
                              "https://images.unsplash.com/photo-1604580864964-0462f5d5b1a8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80",
                              height: mediaQuery.size.height * 0.45,
                              width: mediaQuery.size.height * 1,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "lorem ipsum is simply dummy text of the printing and typesetting industry. Versione app 1.0.1",
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey)),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => {
                                mapBloc.add(OpeningExternalMap(
                                    loc.coordinate?.lat ?? 0.0,
                                    loc.coordinate?.lng ?? 0.0))
                              },
                              child: Text(
                                "raggiungi con google maps",
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.start,
                                textScaleFactor: 1,
                                text: TextSpan(
                                  text: "via del successo, piacenza 29120",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

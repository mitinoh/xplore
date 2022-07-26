import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore/app/map/bloc_user_position/user_position_bloc.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/confirm_button.dart';

import 'package:async/async.dart';

// ignore: must_be_immutable
class MapsBottomSheet extends StatelessWidget {
  MapsBottomSheet({Key? key, required this.context}) : super(key: key);

  BuildContext context;
  @override
  Widget build(BuildContext ctx) {
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);
    MapPosition currentMapPosition = MapPosition();
    RestartableTimer _timer = RestartableTimer(
      const Duration(seconds: 1),
      () {},
    );
    return SafeArea(
      child: Container(
        height: mediaQuery.size.height * 0.78,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: mediaQuery.size.height * 0.78,
                  child: BlocProvider(
                    create: (ct) =>
                        UserPositionBloc()..add(GetUserPositionEvent()),
                    child: BlocBuilder<UserPositionBloc, UserPositionState>(
                      builder: (ct, state) {
                        if (state is UserPositionLoaded) {
                          return Column(
                            children: [
                              Expanded(
                                child: Stack(children: [
                                  FlutterMap(
                                      options: MapOptions(
                                        onPositionChanged:
                                            ((position, hasGesture) {
                                          _timer.reset();
                                          currentMapPosition = position;
                                        }),
                                        center: LatLng(
                                            state.userPosition.latitude,
                                            state.userPosition.longitude),
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
                                      ]),
                                  InkWell(
                                      onTap: () {
                                        context
                                                    .read<PlantripBloc>()
                                                    .planTripQuestionsMap[
                                                "latitude"] =
                                            currentMapPosition.center?.latitude;
                                        context
                                                    .read<PlantripBloc>()
                                                    .planTripQuestionsMap[
                                                "longitude"] =
                                            currentMapPosition
                                                .center?.longitude;

                                        context.read<PlantripBloc>().add(
                                            PlanTripChangeQuestionEvent(
                                                increment: true));
                                      },
                                      child: ConfirmButton(
                                        text: "Conferma",
                                        colors: UIColors.mainColor,
                                        colorsText: Colors.black,
                                      )),
                                ]),
                              ),
                            ],
                          );
                        } else {
                          return const Text("error");
                        }
                      },
                    ),
                    /*
                     FlutterMap(
                      options: MapOptions(
                        zoom: 9.2,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        ),
                      ],
                    ),*/
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

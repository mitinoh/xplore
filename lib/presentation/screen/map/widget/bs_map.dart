import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore/presentation/common_widgets/wg_error.dart';
import 'package:xplore/presentation/screen/map/bloc_user_position/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';

class MapsBottomSheet extends StatelessWidget {
  MapsBottomSheet({Key? key, required this.context}) : super(key: key);

  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    MapPosition currentMapPosition = MapPosition();

    return _buildBottomSheet(mediaQuery, currentMapPosition);
  }

  SafeArea _buildBottomSheet(MediaQueryData mediaQuery, MapPosition currentMapPosition) =>
      SafeArea(
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
                      create: (ct) => BlocProvider.of<UserPositionBloc>(context)
                        ..add(GetUserPosition()),
                      child: _builder(currentMapPosition),
                    ),
                  )
                ]),
          ),
        ),
      );

  BlocBuilder<UserPositionBloc, UserPositionState> _builder(
          MapPosition currentMapPosition) =>
      BlocBuilder<UserPositionBloc, UserPositionState>(
        builder: (ct, state) {
          if (state is UserPositionLoaded) {
            return Column(
              children: [
                Expanded(
                  child: Stack(children: [
                    _buildMap(state),
                    _buildConfirmButton(currentMapPosition, state),
                  ]),
                ),
              ],
            );
          } else if (state is UserPositionError) {
            return ErrorScreen(state: state, message: state.message);
          } else {
            return ErrorScreen(state: state);
          }
        },
      );

  InkWell _buildConfirmButton(MapPosition currentMapPosition, UserPositionLoaded state) =>
      InkWell(
          onTap: () {
            context
                    .read<PlannerQuestionBloc>()
                    .planTripQuestions
                    .geometry
                    ?.coordinates?[1] =
                currentMapPosition.center?.latitude ?? state.userPosition.latitude;
            context
                    .read<PlannerQuestionBloc>()
                    .planTripQuestions
                    .geometry
                    ?.coordinates?[0] =
                currentMapPosition.center?.longitude ?? state.userPosition.longitude;

            context
                .read<PlannerQuestionBloc>()
                .add(PlannerChangeQuestion(increment: true));
          },
          child: ConfirmButton(
            text: "Conferma",
            colors: Colors.blue,
            colorsText: Colors.black,
          ));

  FlutterMap _buildMap(UserPositionLoaded state) => FlutterMap(
          options: MapOptions(
            center: LatLng(state.userPosition.latitude, state.userPosition.longitude),
            zoom: 15.0,
          ),
          layers: [
            TileLayerOptions(
              minZoom: 1,
              maxZoom: 20,
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
          ]);
}

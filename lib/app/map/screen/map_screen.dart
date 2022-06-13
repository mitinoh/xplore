import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xplore/app/map/bloc_user_position/user_position_bloc.dart';
import 'package:xplore/app/map/widget/map_container_widget.dart';
import 'package:xplore/core/widgets/snackbar_message.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //final MapBloc _mapBloc = MapBloc();
  late Position position;

  @override
  void initState() {
    // _getUserPosition();
    super.initState();
    // _mapBloc.add(const GetLocationList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          bottom: false,
          child: BlocProvider(
            create: (_) => UserPositionBloc()..add(GetUserPositionEvent()),
            child: BlocListener<UserPositionBloc, UserPositionState>(
              listener: (context, state) {
                if (state is UserPositionError) {
                  SnackBarMessage.show(context, state.message ?? '');
                }
              },
              child: BlocBuilder<UserPositionBloc, UserPositionState>(
                builder: (context, state) {
                  if (state is UserPositionLoaded) {
                    return Column(
                      children: [
                        Expanded(
                          child: MapContainer(
                              context: context, userPosition: state.userPosition
                              //  mapBloc: _mapBloc,
                              ),
                        ),
                      ],
                    );
                  } else {
                    return const Text("error");
                  }
                },
              ),
            ),
          )),
    );
  }
}

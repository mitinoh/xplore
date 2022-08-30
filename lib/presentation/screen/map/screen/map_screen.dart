import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xplore/presentation/screen/map/bloc_user_position/bloc.dart';
import 'package:xplore/presentation/screen/map/widget/map_container_widget.dart';

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
            create: (_) => BlocProvider.of<UserPositionBloc>(context)..add(GetUserPosition()),
            child: BlocBuilder<UserPositionBloc, UserPositionState>(
                builder: (context, state) {
                  if (state is UserPositionLoaded) {
                    return Column(
                      children: [
                        Expanded(
                          child: MapContainer(
                              userPosition: state.userPosition
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
          )),
    );
  }
}

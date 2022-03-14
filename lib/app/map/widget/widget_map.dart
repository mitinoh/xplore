import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore/app/map/bloc/map_bloc.dart';
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is MapLoaded) {
              return MapLayout(
                markers: getMapMarker(state.mapModel),
              );
            } else if (state is MapError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  List<Marker> getMapMarker(List<Location> mapModel) {
    List<Marker> _markers = [];
    for (Location loc in mapModel) {
      _markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(loc.coordinate?.x ?? 0.0, loc.coordinate?.y ?? 0.0),
        builder: (ctx) => GestureDetector(
        onTap: (){
          print("Container clicked");
        },
        child: new Container(
          width: 500.0,
          padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
          color: Colors.green,
          child: new Column(
              children: [
                new Text("Ableitungen"),
              ]
          ),
        )
    )
    
    ,
      ));
    }
    return _markers;
  }
}

class MapLayout extends StatelessWidget {
  const MapLayout({Key? key, required this.markers}) : super(key: key);
  final List<Marker> markers;
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 10.0,
      ),
      layers: [
        TileLayerOptions(
          minZoom: 1,
          maxZoom: 20,
          /*urlTemplate:
              "https://api.mapbox.com/styles/v1/ahmed123bahmud/cl0prc9ct002715s8ar7211zo/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYWhtZWQxMjNiYWhtdWQiLCJhIjoiY2wwcHFheHh0MHR1czNqcGttZXcxcG9lbSJ9.nzJlDO8J8qND7iNB6YdKaw",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoiYWhtZWQxMjNiYWhtdWQiLCJhIjoiY2wwcHFheHh0MHR1czNqcGttZXcxcG9lbSJ9.nzJlDO8J8qND7iNB6YdKaw',
            'id': 'mapbox/streets-v11',
          },*/
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: markers,
        ),
      ],
    );
    ;
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/presentation/screen/map/widget/map_layout_widget.dart';

class MapContainer extends StatelessWidget {
  MapContainer({Key? key, required this.userPosition}) : super(key: key);
  Position userPosition;

  Mongoose mng = Mongoose(filter: []);

  initMng() {
    mng.filter?.add(Filter(
        key: "latitude", operation: "=", value: (userPosition.latitude).toString()));
    mng.filter?.add(Filter(
        key: "longitude", operation: "=", value: (userPosition.longitude).toString()));
    mng.filter?.add(Filter(key: "zoom", operation: "=", value: (15).toString()));
  }

  @override
  Widget build(context) {
    return MapLayout(
      userPosition: userPosition,
    );
  }
}

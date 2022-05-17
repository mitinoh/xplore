import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/model/location_model.dart';

class PtLocationGrid extends StatelessWidget {
  const PtLocationGrid({
    Key? key,
    required this.locationList,
  }) : super(key: key);

  final List<Location> locationList;

  double getRndSize() {
    double size = Random().nextInt(200).toDouble();
    if (size < 100) size = 100;
    return size;
  }

  List<Widget> getLocationCnt() {
    List<Widget> locCnt = [];

    for (var el in locationList) {
      {
        locCnt.add(Container(
          decoration: BoxDecoration(
              color: UIColors.bluelight,
              borderRadius: BorderRadius.circular(20)),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: getRndSize(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    el.name ?? '',
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    }

    return locCnt;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MasonryGrid(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          column: 2,
          children: getLocationCnt()),
    );
  }
}

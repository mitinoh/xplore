import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location/screen/search_screen.dart';
import 'package:xplore/app/location/widget/go_navigation.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/model/location_model.dart';

class Docker extends StatelessWidget {
  const Docker(
      {Key? key,
      required this.locationList,
      required this.indexLocation,
      required this.locationBloc})
      : super(key: key);
  final List<Location> locationList;
  final int indexLocation;
  final LocationBloc locationBloc;

  // ignore: non_constant_identifier_names
  Future LikeLocation() async {
    log(locationList[indexLocation].iId.toString());
    locationBloc.add(
        SaveUserLocation(locationId: locationList[indexLocation].iId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 250,
        right: 20,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: UIColors.violet.withOpacity(0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              InkWell(
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()),
                        )
                      },
                  child: Icon(Iconsax.search_normal, color: UIColors.black)),
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  log(locationList[indexLocation].iId.toString());
                  locationBloc.add(SaveUserLocation(
                      locationId: locationList[indexLocation].iId ?? ''));
                },
                child: Icon(Iconsax.heart, color: UIColors.black),
              ),
              const SizedBox(height: 25),
              InkWell(
                  onTap: () => {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const GoNavigationBottomSheet();
                            })
                      },
                  child: Icon(Iconsax.discover_1, color: UIColors.black)),
              const SizedBox(height: 15),
            ],
          ),
        ));
  }
}

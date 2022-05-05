import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location/screen/search_screen.dart';
import 'package:xplore/app/location/widget/filter_location.dart';
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
              const SizedBox(height: 10),
              InkWell(
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()),
                        )
                      },
                  child: Icon(Iconsax.search_normal, color: UIColors.black)),
              const SizedBox(height: 20),
              LikeButton(
                padding: const EdgeInsets.all(0),
                likeCountPadding: const EdgeInsets.all(0),
                likeBuilder: (bool like) {
                  return IconButton(
                    icon: Icon(Iconsax.heart,
                        color: like ? UIColors.pink : UIColors.black),
                    onPressed: () {
                      log(locationList[indexLocation].iId.toString());
                      locationBloc.add(SaveUserLocation(
                          locationId: locationList[indexLocation].iId ?? ''));
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              InkWell(
                  onTap: () => {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return FilterLocationBottomSheet();
                            })
                      },
                  child: Icon(Iconsax.setting_4, color: UIColors.black)),
              const SizedBox(height: 20),
              InkWell(
                  onTap: () => {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return GoNavigationBottomSheet();
                            })
                      },
                  child: Icon(Iconsax.discover_1, color: UIColors.black)),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/model/location_model.dart';

/*
class LikeButton extends StatelessWidget {
  const LikeButton(
      {Key? key,
      required this.locationList,
      required this.indexLocation,
      required this.locationBloc, // TODO non passare ma ricavare
      this.liked = false})
      : super(key: key);
  final List<LocationModel> locationList;
  final int indexLocation;
  final HomeBloc locationBloc;
  final bool liked;

  @override
  Widget build(BuildContext context) {
    bool isSaved = locationList[indexLocation].saved == true ? true : false;

    return InkWell(
      onTap: () {
        print(isSaved);
        isSaved = !isSaved;
        locationBloc.add(SaveUserLocation(
            locationId: locationList[indexLocation].iId ?? '', save: !isSaved));
      },
      child: Icon(Iconsax.heart,
          color: (isSaved) ? UIColors.lightRed : UIColors.black),
    );
  }
}
*/

class LikeButton extends StatefulWidget {
  const LikeButton(
      {Key? key,
      required this.locationList,
      required this.indexLocation,
      required this.locationBloc, // TODO non passare ma ricavare
      this.liked = false,
      this.callback})
      : super(key: key);
  final List<LocationModel> locationList;
  final int indexLocation;
  final HomeBloc locationBloc;
  final bool liked;
  final VoidCallback? callback;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isSaved = false;
  @override
  void initState() {
    isSaved =
        widget.locationList[widget.indexLocation].saved == false || widget.liked
            ? false
            : true;
    /*
    if (widget.locationList[widget.indexLocation].saved == true ||
        widget.liked) {
      isSaved = true;
    }
    */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          widget.locationList[widget.indexLocation].saved =
              widget.locationList[widget.indexLocation].saved == true ||
                      widget.liked
                  ? false
                  : true;
          if (widget.callback != null) {
            widget.callback!();
          }
        });

        widget.locationBloc.add(SaveUserLocation(
            locationId: widget.locationList[widget.indexLocation].iId ?? '',
            save: widget.locationList[widget.indexLocation].saved == false ||
                    widget.liked ? false: true));
      },
      child: Icon(Iconsax.heart,
          color: (widget.locationList[widget.indexLocation].saved == true)
              ? UIColors.lightRed
              : lightDark.primaryColor),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/model/location_model.dart';

class LikeButton extends StatefulWidget {
  const LikeButton(
      {Key? key,
      required this.locationList,
      required this.indexLocation,
      required this.locationBloc})
      : super(key: key);
  final List<LocationModel> locationList;
  final int indexLocation;
  final HomeBloc locationBloc;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bool isSaved = widget.locationList[widget.indexLocation].saved ?? false;

        setState(() {
          widget.locationList[widget.indexLocation].saved = !isSaved;
        });

        widget.locationBloc.add(SaveUserLocation(
            locationId: widget.locationList[widget.indexLocation].iId ?? '',
            save: !isSaved));
      },
      child: Icon(Iconsax.heart,
          color: widget.locationList[widget.indexLocation].saved == true
              ? UIColors.lightRed
              : UIColors.black),
    );
  }
}

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
      required this.locationBloc,
      this.liked = false})
      : super(key: key);
  final List<LocationModel> locationList;
  final int indexLocation;
  final HomeBloc locationBloc;
  final bool liked;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isSaved = false;

  @override
  void initState() {
    if (widget.locationList[widget.indexLocation].saved == true ||
        widget.liked) {
      isSaved = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSaved = !isSaved;
        });

        widget.locationBloc.add(SaveUserLocation(
            locationId: widget.locationList[widget.indexLocation].iId ?? '',
            save: isSaved));
      },
      child: Icon(Iconsax.heart,
          color: (isSaved) ? UIColors.lightRed : UIColors.black),
    );
  }
}

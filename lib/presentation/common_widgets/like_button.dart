import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeButton extends StatefulWidget {
  const LikeButton(
      {Key? key, required this.locationList, this.liked = false, this.callback})
      : super(key: key);
  final LocationModel locationList;
  final bool liked;
  final VoidCallback? callback;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          context
              .read<HomeBloc>()
              .add(ToggleLikeLocation(location: widget.locationList));

        });
      },
      child: Icon(Iconsax.heart,
          color: widget.locationList.saved ?? false
              ? lightDark.primaryColor
              : lightDark.backgroundColor),
    );
  }
}

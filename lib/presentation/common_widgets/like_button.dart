import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key, required this.location, this.liked = false, this.callback})
      : super(key: key);
  final LocationModel location;
  final bool liked;
  final VoidCallback? callback;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late ThemeData themex = Theme.of(context);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          context.read<HomeBloc>().add(ToggleLikeLocation(location: widget.location));

        });
      },
      child: Icon(Iconsax.heart,
          color: widget.location.saved ?? false
              ? themex.primaryColor
              : themex.disabledColor),
    );
  }
}

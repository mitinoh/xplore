import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xplore/presentation/common_widgets/wg_image.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/planner/bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:xplore/presentation/screen/planner/bloc_current_trip/bloc.dart';
import 'package:xplore/presentation/screen/planner/sc_trip_detail.dart';

class CircleImageWidget extends StatelessWidget {
  const CircleImageWidget({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 53,
      backgroundColor: Colors.lightBlue,
      child: CircleAvatar(
          radius: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: ImageWidget(imageUrl: imageUrl)
          )),
    );
  }
}

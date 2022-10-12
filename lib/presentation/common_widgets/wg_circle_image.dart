import 'package:flutter/material.dart';
import 'package:xplore/presentation/common_widgets/wg_image.dart';

class CircleImageWidget extends StatelessWidget {
  CircleImageWidget({Key? key, required this.imageUrl, this.radius = 50}) : super(key: key);

  final String imageUrl;
  double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + 3,
      backgroundColor: Colors.lightBlue,
      child: CircleAvatar(
          radius: radius,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: ImageWidget(imageUrl: imageUrl))),
    );
  }
}

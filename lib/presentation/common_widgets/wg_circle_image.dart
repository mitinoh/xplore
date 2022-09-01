import 'package:flutter/material.dart';
import 'package:xplore/presentation/common_widgets/wg_image.dart';
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

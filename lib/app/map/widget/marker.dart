import 'package:flutter/material.dart';
import 'package:xplore/core/UIColors.dart';

class MarkerWidget extends StatelessWidget {
  const MarkerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: UIColors.mainColor.withOpacity(0.4),
      child: CircleAvatar(
        radius: 13,
        backgroundColor: UIColors.mainColor,
      ),
    );
  }
}

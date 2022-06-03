import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:xplore/core/UIColors.dart';

class MarkerWidget extends StatelessWidget {
  const MarkerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: UIColors.blue,
      endRadius: 40.0,
      duration: const Duration(milliseconds: 2000),
      repeat: true,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: UIColors.blue.withOpacity(0.4),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: UIColors.blue,
        ),
      ),
    );
  }
}

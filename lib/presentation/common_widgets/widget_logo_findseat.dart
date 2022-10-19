import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetLogoFindSeat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themex = Theme.of(context);
    return SvgPicture.asset(
      'assets/logo.svg',
      color: themex.indicatorColor,
    );
  }
}

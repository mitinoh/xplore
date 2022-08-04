import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xplore/utils/const/COLOR_CONST.dart';

class WidgetLogoFindSeat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logo_find_seat.svg',
      color: COLOR_CONST.WHITE,
    );
  }
}

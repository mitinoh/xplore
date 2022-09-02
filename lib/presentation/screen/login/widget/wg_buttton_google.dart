import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/utils/const/COLOR_CONST.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(GoogleSignInRequested(context: context));
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: COLOR_CONST.GOOGLE_BTN,
            border: Border.all(width: 0.2, color: COLOR_CONST.GOOGLE_BORDER_BTN),
            shape: BoxShape.rectangle),
        child: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset('assets/ic_google.svg', width: 24, height: 24)),
            Text('Google')
          ],
        ),
      ),
    );
  }
}

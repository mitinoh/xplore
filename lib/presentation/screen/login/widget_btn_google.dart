import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/utils/const/COLOR_CONST.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetBtnGoogle extends StatelessWidget {
  late BuildContext _blocContext;
  @override
  Widget build(BuildContext context) {
    _blocContext = context;
    return Expanded(
      child: InkWell(
        onTap: () {
          BlocProvider.of<AuthenticationBloc>(_blocContext)
              .add(GoogleSignInRequested(context: context));
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: COLOR_CONST.GOOGLE_BTN,
              border: Border.all(
                width: 0.2,
                color: COLOR_CONST.GOOGLE_BORDER_BTN,
              ),
              shape: BoxShape.rectangle),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(
                  'assets/ic_google.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              Text(
                'Google',
              )
            ],
          ),
        ),
      ),
    );
  }
}

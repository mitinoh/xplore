import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/presentation/common_widgets/sb_error.dart';
import 'package:xplore/presentation/screen/login/widget/wg_login_form.dart';
import 'package:xplore/presentation/screen/user/bloc_user/user_bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_user/user_event.dart';
import 'package:xplore/presentation/screen/user/sc_edit_profile.dart';

import '../user/bloc_user/user_state.dart';

class LoginScreen extends StatelessWidget {
  late BuildContext _blocContext;
  @override
  Widget build(BuildContext ct) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
          _blocListener(context, state);
        }, builder: (context, state) {
          return _blocBuilder(context, state);
        }),
      ),
    );
  }

  _blocListener(BuildContext context, AuthenticationState state) {
    _blocContext = context;
    if (state is Authenticated) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => App()));
    }
    if (state is AuthError) {
      SbError().show(context);
    }
  }

  _blocBuilder(BuildContext context, AuthenticationState state) => _buildLoginForm();

  _buildLoginForm() => WidgetLoginForm();
}

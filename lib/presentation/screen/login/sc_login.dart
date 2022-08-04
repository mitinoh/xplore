import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/screen/login/bloc/bloc.dart';
import 'package:xplore/presentation/screen/login/widget_login_form.dart';
import 'package:xplore/utils/const/COLOR_CONST.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userRepository = RepositoryProvider.of<UserRepository>(context);

    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(userRepository: userRepository),
        child: Container(
          color: COLOR_CONST.DEFAULT,
          child: ListView(
            children: <Widget>[
              _buildLoginForm(),
            ],
          ),
        ),
      ),
    );
  }

  _buildLoginForm() => WidgetLoginForm();
}

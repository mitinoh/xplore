import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/presentation/screen/login/widget/wg_login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    if (state is Authenticated) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => App()));
    }
    if (state is AuthenticatedNewUser) {
      // pagina modifica
    }
    if (state is AuthError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.message.toString())));
    }
  }

  _blocBuilder(BuildContext context, AuthenticationState state) => _buildLoginForm();

  _buildLoginForm() => WidgetLoginForm();
}

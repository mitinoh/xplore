import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/data/repository/auth_repository.dart';
import 'package:xplore/presentation/screen/login/bloc/bloc.dart';
import 'package:xplore/presentation/screen/login/widget/header_onboarding.dart';
import 'package:xplore/presentation/screen/login/widget/headline.dart';
import 'package:xplore/presentation/screen/login/widget/wg_buttton_google.dart';
import 'package:xplore/presentation/screen/login/widget/wg_login_form.dart';
import 'package:xplore/utils/const/COLOR_CONST.dart';

import 'widget/terms.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authRepository = RepositoryProvider.of<AuthRepository>(context);

    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(authRepository: authRepository),
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // Navigating to the dashboard screen if the user is authenticated
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => App()));
            }
            if (state is AuthenticatedNewUser) {}
            if (state is AuthError) {
              // Showing the error message if the user has entered invalid credentials
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message.toString())));
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Unauthenticated) {
                // Showing the sign in form if the user is not authenticated
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HeaderOnboarding(),
                          const SizedBox(height: 20),
                          const HeadLine(),
                          const SizedBox(height: 20),
                          GoogleButton(),
                          const SizedBox(height: 5),
                          const SizedBox(height: 10),
                          const Terms()
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  _buildLoginForm() => WidgetLoginForm();
}

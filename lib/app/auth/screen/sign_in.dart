import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/auth/screen/user_category_preference_screen.dart';
import 'package:xplore/app/auth/widgets/header_onboarding.dart';
import 'package:xplore/app/auth/widgets/headline.dart';
import 'package:xplore/app/auth/widgets/terms.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/login_button.dart';
import 'package:xplore/main.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => MyApp()));
          }
          if (state is NewUserAuthenticated) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => UserCategoryPreferenceScreen(
                          context: context,
                        )));
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              // Showing the loading indicator while the user is signing in
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
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
                        GestureDetector(
                          onTap: () {
                            _authenticateWithGoogle(context);
                          },
                          child: LoginButton(
                            text: "Google",
                            colors: UIColors.blue,
                          ),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {},
                          child: LoginButton(
                            text: "Apple",
                            colors: lightDark.primaryColor,
                          ),
                        ),
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
    );
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(context),
    );
  }
}

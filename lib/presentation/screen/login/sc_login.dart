import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/presentation/screen/login/widget/wg_login_form.dart';
import 'package:xplore/presentation/screen/user/sc_edit_profile.dart';

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
    if (state is AuthenticatedNewUser) {
      _newUser(context);
    }
    if (state is AuthError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.message.toString())));
    }
  }

  _blocBuilder(BuildContext context, AuthenticationState state) => _buildLoginForm();

  _buildLoginForm() => WidgetLoginForm();

  _newUser(BuildContext context) async {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        elevation: 300,
        context: context,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return EditProfileScreen(
            userData: UserModel(),
            blocContext: _blocContext,
            newUser: true,
            callback: () {
              Navigator.pop(context);
              context.read<AuthenticationBloc>().add(LoggedIn());
            },
          );
        });
  }
}

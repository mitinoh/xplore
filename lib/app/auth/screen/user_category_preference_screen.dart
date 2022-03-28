import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/user/screen/category_preference.dart';
import 'package:xplore/main.dart';

class UserCategoryPreferenceScreen extends StatelessWidget {
  const UserCategoryPreferenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CategoryPreference(
            pipeline: '{}',
          ),
          TextButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  NewUser(CategoryPreference.catSelected),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text("done"))
        ],
      ),
    );
  }
}

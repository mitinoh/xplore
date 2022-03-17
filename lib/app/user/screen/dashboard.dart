import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/auth/screen/sign_in.dart';
import 'package:xplore/app/location/screen/new_location_screen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignIn()),
              (route) => false,
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email: \n ${user.email}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              user.photoURL != null
                  ? Image.network("${user.photoURL}")
                  : Container(),
              user.displayName != null
                  ? Text("${user.displayName}")
                  : Container(),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Sign Out'),
                onPressed: () {
                  // Signing out the user
                  context.read<AuthBloc>().add(SignOutRequested());
                },
              ),
              /* ElevatedButton(
                child: const Text('Post'),
                onPressed: () {
                  // Signing out the user
                  context.read<AuthBloc>().add(NewUser());
                },
              ),*/
              ElevatedButton(
                child: const Text('Delete account'),
                onPressed: () {
                  // Signing out the user
                  context.read<AuthBloc>().add(DeleteAccount());
                },
              ),
              ElevatedButton(
                child: const Text('Aggiungi posto nuovo'),
                onPressed: () {
                  // Signing out the user
                  //context.read<AuthBloc>().add(DeleteAccount());

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewLocation()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

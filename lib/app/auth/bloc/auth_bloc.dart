import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:xplore/app/auth/repository/auth_repository.dart';
import 'package:xplore/app/map/screen/map_screen.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    // When User Presses the SignIn Button, we will send the SignInRequested Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated

    // When User Presses the Google Login Button, we will send the GoogleSignInRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        bool isNewUser = await authRepository.signInWithGoogle(event.context);
        if (isNewUser) {
          emit(NewUserAuthenticated());
        } else {
          emit(Authenticated());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // When User Presses the SignOut Button, we will send the SignOutRequested Event to the AuthBloc to handle it and emit the UnAuthenticated State
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });

    on<NewUser>((event, emit) async {
      //emit(Loading());
      await authRepository.newUserPut();
      // emit(UnAuthenticated());
    });

    on<NewUserRegistered>((event, emit) async {
      emit(Authenticated());
    });

    on<DeleteAccount>((event, emit) async {
      //emit(Loading());
      await authRepository.deleteAccount();
      // emit(UnAuthenticated());
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository}) : super(Uninitialized()) {
    on<AppStarted>(_mapAppStartedToState);
    on<LoggedIn>(_mapLoggedInToState);
    on<LoggedOut>(_mapLoggedOutToState);
    on<GoogleSignInRequested>(_googleSignInRequest);
  }

  void _mapAppStartedToState(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    try {
      final isSignedIn = await userRepository.isSignedIn();
      //for display splash screen
      await Future.delayed(Duration(seconds: 2));
      if (isSignedIn) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  void _mapLoggedInToState(
      LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(Authenticated());
  }

  void _mapLoggedOutToState(
      LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(Unauthenticated());
    userRepository.signOut();
  }

  void _googleSignInRequest(
      GoogleSignInRequested event, Emitter<AuthenticationState> emit) async {
    emit(Unauthenticated());
    UserCredential authResult = await userRepository.signInWithGoogle();
    bool isSignedIn = await userRepository.isSignedIn();

    if (isSignedIn) {
      if (authResult.additionalUserInfo?.isNewUser ?? false)
        emit(AuthenticatedNewUser());
      else
        emit(Authenticated());
    } else
      emit(Unauthenticated());
  }
}

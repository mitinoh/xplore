import 'package:bloc/bloc.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/model/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xplore/utils/logger.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc({required this.authRepository}) : super(Uninitialized()) {
    on<AppStarted>(_mapAppStartedToState);
    on<LoggedIn>(_mapLoggedInToState);
    on<LoggedOut>(_mapLoggedOutToState);
    on<GoogleSignInRequested>(_googleSignInRequest);
  }

  void _mapAppStartedToState(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    try {
      final isSignedIn = await authRepository.isSignedIn();
      //for display splash screen
      await Future.delayed(Duration(seconds: 2));
      if (isSignedIn) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
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
    authRepository.signOut();
  }

  void _googleSignInRequest(
      GoogleSignInRequested event, Emitter<AuthenticationState> emit) async {
    emit(Unauthenticated());
    UserCredential authResult = await authRepository.signInWithGoogle();
    bool isSignedIn = await authRepository.isSignedIn();

    if (isSignedIn) {
      if (authResult.additionalUserInfo?.isNewUser ?? false)
        emit(AuthenticatedNewUser());
      else
        emit(Authenticated());
    } else
      emit(Unauthenticated());
  }
}

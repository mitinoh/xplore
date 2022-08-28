import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:xplore/data/repository/auth_repository.dart';
import 'package:xplore/presentation/screen/login/bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginState.empty());

  @override
  LoginState get initialState => LoginState.empty();
}

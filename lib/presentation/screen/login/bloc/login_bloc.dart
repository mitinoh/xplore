
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/screen/login/bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginState.empty());

  @override
  LoginState get initialState => LoginState.empty();



}

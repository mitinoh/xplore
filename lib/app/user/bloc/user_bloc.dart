import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/user/api_repository.dart';
import 'package:xplore/app/user/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetUserList>((event, emit) async {
      try {
        emit(UserLoading());
        final List<UserModel> mList = await _apiRepository.fetchUserList();
        emit(UserLoaded(mList));
      } on NetworkError {
        emit(UserError("Failed to fetch data. is your device online?"));
      }
    });

    on<AddedUserElement>((event, emit) async {
      try {
        emit(UserAdded());
        await _apiRepository.aaddUserElement("test");
      } on NetworkError {
        emit(UserError("Failed to fetch data. is your device online?"));
      }
    });

    on<Test>((event, emit) async {
      int i = event.amount;
      i = i * 2 + 3;
      log(i.toString());
      print("test");
    });
  }
}

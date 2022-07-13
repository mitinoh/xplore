import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/user/repository/follower_repository.dart';
import 'package:xplore/model/follower_count_model.dart';
import 'package:xplore/model/follower_model.dart';

part 'follower_event.dart';
part 'follower_state.dart';

class FollowerBloc extends Bloc<FollowerEvent, FollowerState> {
  FollowerBloc() : super(FollowerInitial()) {
    FollowerRepository followerRepository = FollowerRepository();

    on<FollowerGetListEvent>((event, emit) async {
      try {
        final FollowerModel followerList =
            await followerRepository.getFollower(event.uid);
        emit(FollowerLoadedState(followerList));
      } catch (e, stacktrace) {
        log(stacktrace.toString());
        emit(FollowerError(e.toString()));
      }
    });
  }
}

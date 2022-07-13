import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/user/repository/follower_repository.dart';
import 'package:xplore/model/follower_count_model.dart';
import 'package:xplore/model/mongoose_model.dart';

part 'follower_count_event.dart';
part 'follower_count_state.dart';

class FollowerCountBloc extends Bloc<FollowerCountEvent, FollowerCountState> {
  FollowerCountBloc() : super(FollowerCountInitial()) {
    FollowerRepository followerRepository = FollowerRepository();

    on<FollowerGetCountListEvent>((event, emit) async {
      try {
        final FollowerCountModel followerCount =
            await followerRepository.getFollowerCount(event.uid);
        emit(FollowerCountLoadedState(followerCount));
      } catch (e, stacktrace) {
        log(stacktrace.toString());
        emit(FollowerError(e.toString()));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:xplore/data/repository/follower_repository.dart';
import 'package:xplore/presentation/screen/user/bloc_follower/bloc.dart';
import 'package:xplore/utils/logger.dart';

class FollowerBloc extends Bloc<FollowerEvent, FollowerState> {
  final FollowerRepository followerRepository;
  FollowerBloc({required this.followerRepository})
      : super(FollowerLoadingState()) {
    on<IsFollowingUser>(_isFollowingUser);
    on<ToggleFollow>(_toggleFollow);
  }

  void _isFollowingUser(
    IsFollowingUser event,
    Emitter<FollowerState> emit,
  ) async {
    try {
      bool isFollowing = await followerRepository.isFollowing(event.uid);
      emit(FollowingUser(following: isFollowing));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(FollowerError(e.toString()));
    }
  }

  void _toggleFollow(
    ToggleFollow event,
    Emitter<FollowerState> emit,
  ) async {
    try {
      await followerRepository.toggleFollow(event.uid, event.following);

      emit(FollowingUser(following: !event.following));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(FollowerError(e.toString()));
    }
  }
}

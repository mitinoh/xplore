import 'package:bloc/bloc.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/repository/home_repository.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';
import 'package:xplore/utils/logger.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc({required this.homeRepository}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetLocationList>(_mapAppStartedToState);
    on<ToggleLikeLocation>(_toggleLikeLocation);
    on<NavigateToLocation>(_navigateToLocation);
  }

  void _mapAppStartedToState(GetLocationList event, Emitter<HomeState> emit) async {
    try {
      Mongoose mng = event.mongoose != null ? event.mongoose! : Mongoose();
      final response = await homeRepository.getLocationList(mng);
      emit(HomeLoaded(homeList: response));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(HomeError(e.toString()));
    }
  }

  void _toggleLikeLocation(ToggleLikeLocation event, Emitter<HomeState> emit) async {
    try {
      final state = this.state;
      event.location.saved = !event.location.saved!;

      if (state is HomeLoaded) {
        final idx = state.homeList.indexWhere((el) => el.id == event.location.id);
        if (idx >= 0) {
          state.homeList.replaceRange(idx, idx + 1, [event.location]);
          emit(HomeLoaded(homeList: state.homeList));
        }
      }
      await homeRepository.toggleLocationLike(event.location);
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(HomeError(e.toString()));
    }
  }

  void _navigateToLocation(NavigateToLocation event, Emitter<HomeState> emit) async {
    homeRepository.navigateToLocation(event.latitude, event.longitude);
  }
}

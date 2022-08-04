import 'package:bloc/bloc.dart';
import 'package:xplore/model/repository/home_repository.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc({required this.homeRepository}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetLocationList>(_mapAppStartedToState);
    on<ToggleLikeLocation>(_toggleLikeLocation);
    on<NavigateToLocation>(_navigateToLocation);
  }

  void _mapAppStartedToState(
      GetLocationList event, Emitter<HomeState> emit) async {
    try {
      final response = await homeRepository.getHomeData();
      emit(HomeLoaded(homeList: response));
    } catch (_) {}
  }

  void _toggleLikeLocation(
      ToggleLikeLocation event, Emitter<HomeState> emit) async {
    event.location.saved = !event.location.saved!;
    await homeRepository.toggleLocationLike(event.location);
  }

  void _navigateToLocation(
      NavigateToLocation event, Emitter<HomeState> emit) async {
    homeRepository.navigateToLocation(event.latitude, event.longitude);
  }
}

import 'package:bloc/bloc.dart';
import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:xplore/model/repository/home_repository.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/screen/search/bloc/bloc.dart';
import 'package:xplore/utils/logger.dart';

class SearchLocationBloc
    extends Bloc<SearchLocationEvent, SearchLocationState> {
  final HomeRepository homeRepository;
  final UserRepository userRepository;
  SearchLocationBloc(
      {required this.homeRepository, required this.userRepository})
      : super(SearchLocationInitial()) {
    //on<SearchLocationEvent>((event, emit) {});
    on<GetSearchLocationList>(_searchLocationList);
    on<GetSearchUsersList>(_searchUserList);
  }

  void _searchLocationList(
      GetSearchLocationList event, Emitter<SearchLocationState> emit) async {
    try {
      Mongoose mng = homeRepository.getMongoose(searchName: event.searchName);
      List<LocationModel> locationsFound =
          await homeRepository.getHomeData(mng);
      emit(SearchLocationLoaded(locationsFound));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(SearchLocationError(e.toString()));
    }
  }

  void _searchUserList(
      GetSearchUsersList event, Emitter<SearchLocationState> emit) async {
    try {
      Mongoose mng = userRepository.getMongoose(searchName: event.searchName);

        List<UserModel> usersFound = await userRepository.getUserList(mng);

        emit(SearchUserLoaded(usersFound));
        
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(SearchLocationError(e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/repository/home_repository.dart';
import 'package:xplore/presentation/screen/search/bloc/bloc.dart';

class SearchLocationBloc
    extends Bloc<SearchLocationEvent, SearchLocationState> {
  final HomeRepository homeRepository;
  SearchLocationBloc({required this.homeRepository})
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
    } catch (e) {
      emit(const SearchLocationError(
          "Failed to fetch data. is your device online?"));
    }
  }

  void _searchUserList(
      GetSearchUsersList event, Emitter<SearchLocationState> emit) async {
    try {
      Mongoose mng = Mongoose(filter: []);
      mng.filter?.add(Filter(
          key: "username",
          operation: "=",
          value: '/${event.searchName?.substring(1) ?? ""}/'));
/*
        final mList = await _userRepository.getUserList(mng);

        emit(SearchUserLoaded(mList));
        */
    } catch (e) {
      emit(const SearchLocationError(
          "Failed to fetch data. is your device online?"));
    }
  }
}

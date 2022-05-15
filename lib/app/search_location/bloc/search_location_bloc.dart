import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/home/repository/home_repository.dart';
import 'package:xplore/model/location_model.dart';

import '../../../model/mongoose_model.dart';

part 'search_location_event.dart';
part 'search_location_state.dart';

class SearchHomeBloc extends Bloc<SearchLocationEvent, SearchLocationState> {
  SearchHomeBloc() : super(SearchLocationInitial()) {
    final HomeRepository _locationRepository = HomeRepository();
    on<SearchLocationEvent>((event, emit) {});
    on<GetSearchLocationList>((event, emit) async {
      try {
        emit(SearchLocationLoading());

        Mongoose mng =
            _locationRepository.getMongoose(searchName: event.searchName);

        final mList = await _locationRepository.getLocationList(mng: mng);

        emit(SearchLocationLoaded(mList, event.add));
      } catch (e) {
        emit(const SearchLocationError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}

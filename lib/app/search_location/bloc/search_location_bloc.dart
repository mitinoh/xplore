import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/location/repository/location_repository.dart';
import 'package:xplore/model/location_model.dart';

import '../../../model/mongoose_model.dart';

part 'search_location_event.dart';
part 'search_location_state.dart';

class SearchLocationBloc
    extends Bloc<SearchLocationEvent, SearchLocationState> {
  SearchLocationBloc() : super(SearchLocationInitial()) {
    final LocationRepository _locationRepository = LocationRepository();
    on<SearchLocationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetSearchLocationList>((event, emit) async {
      try {
        emit(SearchLocationLoading());

        Mongoose mng =
            _locationRepository.getMongoose(searchName: event.searchName);

        final mList = await _locationRepository.fetchLocationList(mng: mng);
        log(mList.toString());
        log("loaded");
        emit(SearchLocationLoaded(mList, event.add));
      } catch (e) {
        //throw Exception('FooException');
        log("err1");
        emit(const SearchLocationError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}

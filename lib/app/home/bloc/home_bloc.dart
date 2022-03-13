import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/home/repository/home_repository.dart';
import 'package:xplore/model/location_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    final HomeRepository _homeRepository = HomeRepository();
    on<HomeEvent>((event, emit) {});

    on<GetLocationList>((event, emit) async {
      try {
        emit(HomeLoading());

        String pipe = _homeRepository.getPipeline(searchName: event.searchName);
        final mList = await _homeRepository.fetchLocationList(body: pipe);

        emit(HomeLoaded(mList));
       
      } on NetworkError {
        emit(const HomeError("Failed to fetch data. is your device online?"));
      }
    });
  }
}

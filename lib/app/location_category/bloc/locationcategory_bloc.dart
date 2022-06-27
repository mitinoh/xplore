import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/location_category/repository/locationcategory_repository.dart';
import 'package:xplore/model/location_category_model.dart';

part 'locationcategory_event.dart';
part 'locationcategory_state.dart';

class LocationCategoryBloc
    extends Bloc<LocationcategoryEvent, LocationcategoryState> {
  LocationCategoryBloc() : super(LocationcategoryInitial()) {
    final LocationCategoryRepository _locCatRepository =
        LocationCategoryRepository();
    on<LocationcategoryEvent>((event, emit) {});

    on<GetLocationCategoryList>((event, emit) async {
      try {
        emit(LocationCategoryLoading());
        final catList = await _locCatRepository.getLocationCategoryList();
        emit(LocationcategoryLoaded(catList));
      } on NetworkError catch (exception) {
        log(exception.toString());
        emit(const LocationcategoryError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}

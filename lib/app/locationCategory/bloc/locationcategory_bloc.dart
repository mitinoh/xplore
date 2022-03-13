import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/locationCategory/repository/locationcategory_repository.dart';
import 'package:xplore/model/locationCategory_model.dart';

part 'locationcategory_event.dart';
part 'locationcategory_state.dart';

class LocationcategoryBloc extends Bloc<LocationcategoryEvent, LocationcategoryState> {
  LocationcategoryBloc() : super(LocationcategoryInitial()) {

    final LocationCategoryRepository _locCatRepository = LocationCategoryRepository();
    on<LocationcategoryEvent>((event, emit) {
    });



     on<GetLocationCategoryList>((event, emit) async {
      try {
        emit(LocationCategoryLoading());
        final catList = await _locCatRepository.fetchLocationCategoryList();
        emit(LocationcategoryLoaded(catList));
        /*if (mList. != null) {
          emit(HomeError(mList.error));
        }*/
      } on NetworkError {
        emit(LocationcategoryError("Failed to fetch data. is your device online?"));
      }
    });
  }
}

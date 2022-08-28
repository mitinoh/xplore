import 'package:bloc/bloc.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/data/repository/location_category_repository.dart';
import 'package:xplore/presentation/screen/home/bloc_location_category/bloc.dart';
import 'package:xplore/utils/logger.dart';

class LocationCategoryBloc extends Bloc<LocationCategoryEvent, LocationCategoryState> {
  final LocationCategoryRepository locationCategroyRepository;
  LocationCategoryBloc({required this.locationCategroyRepository})
      : super(LocationCategoryLoading()) {
    on<GetLocationCategoryList>(_getLocationCategories);
  }

  void _getLocationCategories(
      GetLocationCategoryList event, Emitter<LocationCategoryState> emit) async {
    try {
      final List<LocationCategoryModel> categoriesList =
          await locationCategroyRepository.getLocationCategoryList();
      emit(LocationCategoryLoaded(locationCategoryList: categoriesList));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(LocationCategoryError(e.toString()));
    }
  }
}

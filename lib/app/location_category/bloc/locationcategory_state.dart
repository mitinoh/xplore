part of 'locationcategory_bloc.dart';

abstract class LocationcategoryState extends Equatable {
  const LocationcategoryState();

  @override
  List<Object> get props => [];
}

class LocationcategoryInitial extends LocationcategoryState {}

class LocationCategoryLoading extends LocationcategoryState {}

class LocationcategoryLoaded extends LocationcategoryState {
  final List<LocationCategoryModel> locationCategoryModel;
  const LocationcategoryLoaded(this.locationCategoryModel);
}

class LocationcategoryError extends LocationcategoryState {
  final String? message;
  const LocationcategoryError(this.message);
}

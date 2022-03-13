part of 'locationcategory_bloc.dart';

abstract class LocationcategoryEvent extends Equatable {
  const LocationcategoryEvent();

  @override
  List<Object> get props => [];
}

class GetLocationCategoryList extends LocationcategoryEvent {}
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/app/plantrip/repository/plan_trip_repository.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';
import 'package:xplore/model/plan_trip_model.dart';

part 'plantrip_event.dart';
part 'plantrip_state.dart';

class PlantripBloc extends Bloc<PlantripEvent, PlantripState> {
  PlantripBloc() : super(PlantripInitial()) {
    final PlanTripRepository _planTripRepository = PlanTripRepository();
    on<PlantripEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetLocation>((event, emit) async {
      emit(PlantripLoadingLocation());
      List<LocationModel> loc = await _planTripRepository.getLocationList(
          /*body: event.body,*/ mng: event.mng);
      emit(PlantripLoadedLocation(loc));
    });
    on<SaveTrip>((event, emit) async {
      await _planTripRepository.newPlanTripPut(body: event.body);
      //emit(PlantripLoadedLocation(loc));
    });
    on<GetPlannedTrip>((event, emit) async {
      List<PlanTripModel> plannedTrip =
          await _planTripRepository.getPlannedTripList();
      List<PlanTripModel> currentPlannedTrip =
          await _planTripRepository.getCurrentPlannedTripList();
      emit(PlantripLoadedPlannedTrip(plannedTrip, currentPlannedTrip));
    });
    on<PlanTripLocationNotFound>((event, emit) async {
      log(event.message);
      emit(PlanTripError(event.message));
    });
    on<StartQuest>((event, emit) async {
      emit(PlanTripStartQuest());
    });
  }
}

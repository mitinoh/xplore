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
      List<Location> loc =
          await _planTripRepository.fetchLocationList(/*body: event.body,*/ mng: event.mng);
      emit(PlantripLoadedLocation(loc));
    });
    on<SaveTrip>((event, emit) async {
      await _planTripRepository.newPlanTripPut(body: event.body);
      //emit(PlantripLoadedLocation(loc));
    });
    on<GetPlannedTrip>((event, emit) async {
      List<PlanTrip> plannedTrip = await _planTripRepository.fetchPlannedTripList(body: event.body);
      emit(PlantripLoadedPlannedTrip(plannedTrip));
    });
  }
}

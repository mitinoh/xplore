import 'package:bloc/bloc.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/data/repository/planner_repository.dart';
import 'package:xplore/presentation/screen/planner/bloc/bloc.dart';
import 'package:xplore/utils/logger.dart';

class PlannerBloc extends Bloc<PlannerEvent, PlannerState> {
  final PlannerRepository plannerRepository;
  PlannerBloc({required this.plannerRepository}) : super(PlannerInitial()) {
    on<PlannerEvent>((event, emit) {});
    on<GetPlannedTrip>(_getPlannedTrip);
  }

  void _getPlannedTrip(GetPlannedTrip event, Emitter<PlannerState> emit) async {
    try {
      List<PlannerModel> futurePlannedTrip = await plannerRepository
          .getPlannedTripList(plannerRepository.getFutureTripMng);
      List<PlannerModel> inProgressPlannedTrip = await plannerRepository
          .getPlannedTripList(plannerRepository.getInProgressTripMng);
      emit(PlantripLoadedTrip(
          inProgressTrip: inProgressPlannedTrip,
          futureTrip: futurePlannedTrip));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(PlannerError(e.toString()));
    }
  }
}

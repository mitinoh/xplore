import 'package:bloc/bloc.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/data/repository/planner_repository.dart';
import 'package:xplore/presentation/screen/planner/bloc_current_trip/bloc.dart';
import 'package:xplore/utils/logger.dart';

class CurrentPlannerBloc
    extends Bloc<CurrentPlannerEvent, CurrentPlannerState> {
  final PlannerRepository plannerRepository;
  CurrentPlannerBloc({required this.plannerRepository})
      : super(CurrentPlannerInitial()) {
    on<CurrentPlannerEvent>((event, emit) {});
    on<GetCurrentPlannedTrip>(_getPlannedTrip);
  }

  void _getPlannedTrip(
      GetCurrentPlannedTrip event, Emitter<CurrentPlannerState> emit) async {
    try {
      List<PlannerModel> inProgressPlannedTrip = await plannerRepository
          .getPlannedTripList(plannerRepository.getInProgressTripMng);
      emit(CurrentPlantripLoadedTrip(inProgressTrip: inProgressPlannedTrip));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(CurrentPlannerError(e.toString()));
    }
  }
}

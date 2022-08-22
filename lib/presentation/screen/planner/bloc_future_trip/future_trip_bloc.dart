import 'package:bloc/bloc.dart';
import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/model/planner_model.dart';
import 'package:xplore/model/repository/home_repository.dart';
import 'package:xplore/model/repository/planner_repository.dart';
import 'package:xplore/presentation/screen/planner/bloc_future_trip/bloc.dart';
import 'package:xplore/utils/logger.dart';

class FuturePlannerBloc extends Bloc<FuturePlannerEvent, FuturePlannerState> {
  final PlannerRepository plannerRepository;
  FuturePlannerBloc({required this.plannerRepository})
      : super(FuturePlannerInitial()) {
    on<FuturePlannerEvent>((event, emit) {});
    on<GetFuturePlannedTrip>(_getPlannedTrip);
  }

  void _getPlannedTrip(
      GetFuturePlannedTrip event, Emitter<FuturePlannerState> emit) async {
    try {
      List<PlannerModel> futurePlannedTrip = await plannerRepository
          .getPlannedTripList(plannerRepository.getFutureTripMng);
      emit(FuturePlannerTripLoaded(futureTrip: futurePlannedTrip));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(FuturePlannerError(e.toString()));
    }
  }
}

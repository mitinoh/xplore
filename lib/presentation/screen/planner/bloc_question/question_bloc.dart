import 'package:bloc/bloc.dart';
import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/model/planner_model.dart';
import 'package:xplore/model/repository/home_repository.dart';
import 'package:xplore/model/repository/planner_repository.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';
import 'package:xplore/utils/logger.dart';

class PlannerQuestionBloc
    extends Bloc<PlannerQuestionEvent, PlannerQuestionState> {
  final PlannerRepository plannerRepository;
  final HomeRepository homeRepository = HomeRepository();
  PlannerModel planTripQuestions = PlannerModel();

  PlannerQuestionBloc({required this.plannerRepository})
      : super(PlannerQuestionInitial()) {
    on<PlannerChangeQuestion>(_plannerChangeQuestion);
    on<PlannerGetLocation>(_plannerGetMatchedLocations);
    on<PlannerEndQuestion>(_plannerQuestionComplete);
    on<SaveTrip>(_plannerQuestionSaveTrip);
  }

  void _plannerChangeQuestion(
      PlannerChangeQuestion event, Emitter<PlannerQuestionState> emit) async {
    try {
      if (event.increment) {
        emit(PlannerNextQuestion());
      } else {
        emit(PlannerPreviousQuestion());
      }
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(PlannerQuestionError(message: e.toString()));
    }
  }

  void _plannerGetMatchedLocations(
      PlannerGetLocation event, Emitter<PlannerQuestionState> emit) async {
    try {
      final List<LocationModel> locations =
          await homeRepository.getHomeData(event.mng);
      emit(PlannerQuestionLocationsLoaded(locations: locations));
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(PlannerQuestionError(message: e.toString()));
    }
  }

  void _plannerQuestionComplete(
      PlannerEndQuestion event, Emitter<PlannerQuestionState> emit) async {
    try {
      emit(PlannerQuestionCompleted());
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(PlannerQuestionError(message: e.toString()));
    }
  }

  void _plannerQuestionSaveTrip(
      SaveTrip event, Emitter<PlannerQuestionState> emit) async {
    try {
      plannerRepository.savePlannedTrip(event.newTrip);
      emit(PlannerQuestionCompleted());
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(PlannerQuestionError(message: e.toString()));
    }
  }
}

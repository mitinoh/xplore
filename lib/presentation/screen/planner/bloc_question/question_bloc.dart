import 'package:bloc/bloc.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/data/repository/home_repository.dart';
import 'package:xplore/data/repository/planner_repository.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';
import 'package:xplore/utils/logger.dart';

class PlannerQuestionBloc
    extends Bloc<PlannerQuestionEvent, PlannerQuestionState> {
  final PlannerRepository plannerRepository;
  final HomeRepository homeRepository = HomeRepository();
  PlannerModel planTripQuestions = PlannerModel();

  PlannerQuestionBloc({required this.plannerRepository})
      : super(PlannerQuestionInitial()) {
    on<PlannerInitQuestion>(_plannerInitQuestion);
    on<PlannerChangeQuestion>(_plannerChangeQuestion);
    on<PlannerGetLocation>(_plannerGetMatchedLocations);
    on<PlannerEndQuestion>(_plannerQuestionComplete);
    on<SaveTrip>(_plannerQuestionSaveTrip);
  }

  void _plannerInitQuestion(
      PlannerInitQuestion event, Emitter<PlannerQuestionState> emit) async {
    try {
      emit(PlannerQuestionInitial());
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(PlannerQuestionError(message: e.toString()));
    }
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
          await homeRepository.getLocationList(event.mng);
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

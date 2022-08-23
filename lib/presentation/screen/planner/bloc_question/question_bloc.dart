import 'package:bloc/bloc.dart';
import 'package:xplore/model/api/mongoose.dart';
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

  Map<String, dynamic> planTripQuestionsMap = {};

  PlannerQuestionBloc({required this.plannerRepository})
      : super(PlannerQuestionInitial()) {
    on<PlannerChangeQuestion>(_plannerChangeQuestion);
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
}

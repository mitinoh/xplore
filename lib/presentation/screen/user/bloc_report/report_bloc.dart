import 'package:bloc/bloc.dart';
import 'package:xplore/data/repository/report_repository.dart';
import 'package:xplore/presentation/screen/user/bloc_report/bloc.dart';
import 'package:xplore/utils/logger.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository reportRepository;
  ReportBloc({required this.reportRepository}) : super(ReportInitState()) {
    on<ReportUser>(_reportUser);
  }

  void _reportUser(
    ReportUser event,
    Emitter<ReportState> emit,
  ) async {
    try {
      await reportRepository.reportUser(event.reportData);
      emit(UserReported());
    } catch (e, stacktrace) {
      Logger.error(stacktrace.toString());
      emit(ReportError(e.toString()));
    }
  }
}

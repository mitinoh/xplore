import 'package:xplore/model/model/location_model.dart';
import 'package:equatable/equatable.dart';


abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}


class ReportInitState extends ReportState{}

class UserReported extends ReportState{}

class ReportError extends ReportState {
  final String? message;
  const ReportError(this.message);
}

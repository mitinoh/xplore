import 'package:xplore/data/model/location_model.dart';
import 'package:equatable/equatable.dart';
import 'package:xplore/data/model/report_model.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class ReportUser extends ReportEvent {
  final ReportModel reportData;
  const ReportUser({required this.reportData});
}

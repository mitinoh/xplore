import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/api/rest_client.dart';
import 'package:xplore/data/dio_provider.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/report_model.dart';
import 'package:xplore/data/model/user_model.dart';

class ReportRepository {
  final dio = DioProvider.instance();
  Future<dynamic> reportUser(ReportModel reportData) async {
    final client = RestClient(await dio);
    return await client.reportUser(reportData);
  }
}

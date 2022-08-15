import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/api/rest_client.dart';
import 'package:xplore/model/dio_provider.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/model/report_model.dart';
import 'package:xplore/model/model/user_model.dart';

class ReportRepository {
  
  final dio = DioProvider.instance();
  Future<dynamic> reportUser(ReportModel reportData) async {
    final client = RestClient(await dio);
    return await client.reportUser(reportData);
  }

}

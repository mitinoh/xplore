import 'package:dio/dio.dart';
import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/api/rest_client.dart';
import 'package:xplore/model/dio_provider.dart';
import 'package:xplore/model/model/location_category_model.dart';
class LocationCategoryRepository {


  final dio = DioProvider.instance();
  
  Future<List<LocationCategoryModel>> getLocationCategoryList() async {
     final client = RestClient(await dio);
    return await client.getLocationCategories();
  }
}

class NetworkError extends Error {}

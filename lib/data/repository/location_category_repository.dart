import 'package:xplore/data/api/rest_client.dart';
import 'package:xplore/data/dio_provider.dart';
import 'package:xplore/data/model/location_category_model.dart';

class LocationCategoryRepository {
  final dio = DioProvider.instance();

  Future<List<LocationCategoryModel>> getLocationCategoryList() async {
    final client = RestClient(await dio);
    return await client.getLocationCategories();
  }
}

class NetworkError extends Error {}

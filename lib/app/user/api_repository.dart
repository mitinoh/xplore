
import 'package:xplore/app/user/user_model.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = UserApiProvider();

  Future<List<UserModel>> fetchUserList() {
    return _provider.fetchUserList();
  }

  Future<void> addUserElement(String name) {
    print("emit");
    return _provider.addUserList(name);
  }

  aaddUserElement(String s) {}
}

class NetworkError extends Error {}

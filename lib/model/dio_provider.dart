import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xplore/model/repository/user_repository.dart';

class DioProvider {
  static Future<Dio> instance() async {
    UserRepository _userRepository = UserRepository();
    final dio = Dio();

//    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(HttpLogInterceptor());
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["auth"] = await _userRepository.getUserToken();

    return dio;
  }
}

class HttpLogInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log("onRequest: ${options.uri}\n"
        "data=${options.data}\n"
        "method=${options.method}\n"
        "headers=${options.headers}\n"
        "queryParameters=${options.queryParameters}");
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // log("statusCode=${response.statusCode}\n" "responseBody=${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log("onError: $err\n"
        "Response: ${err.response}");
    super.onError(err, handler);
  }
}

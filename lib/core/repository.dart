import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:xplore/core/config.dart';
import 'package:dio/dio.dart';
import 'package:xplore/model/coordinate_model.dart';
import 'package:xplore/model/location_model.dart';

class Repository {
  final user = FirebaseAuth.instance.currentUser!;

  Config conf = Config();

  Future setDio(Dio dio) async {
    dio.options.headers['content-Type'] = 'application/json';
    // user.getIdToken().then((value) => dio.options.headers["tkn"] = value);
    dio.options.headers["tkn"] = await user.getIdToken();
  }

  Dio _dio = Dio();
  Future doPost({String? endp, Object? obj}) async {
    /* await setDio(_dio);

    Response response;
    endp = endp ?? "";
    obj = obj ?? {};
    String url = conf.ip + endp;
    log(url);
    response = await _dio.post(url, data: obj);
    log(response.toString());
    return response;
    */
  }

  Future<void> doPut({String? endp, Object? obj}) async {
    await setDio(_dio);
    Response response;
    endp = endp ?? "";
    obj = obj ?? {};
    String url = conf.ip + endp;
    response = await _dio.put(url, data: obj);

    log(response.statusCode.toString());
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:xplore/core/config.dart';
import 'package:dio/dio.dart';
import 'package:xplore/model/coordinate_model.dart';
import 'package:xplore/model/location_model.dart';

class Repository {
  Config conf = Config();

  Future setDio(Dio dio) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (FirebaseAuth.instance.currentUser != null) {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["tkn"] = await user?.getIdToken();
    }
  }

  String getUserID() {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  final Dio _dio = Dio();
  Future doPost({String? endp, Object? obj}) async {

  }

  Future<Response> doPut(
      {required String url, required data}) async {
    try {
      await setDio(_dio);
      return await _dio.put(url, data: data);
    } catch (e) {
      throw Exception(e);
    }
  }
}

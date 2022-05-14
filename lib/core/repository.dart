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
      dio.options.headers["authorization"] = await user?.getIdToken();
    }

    // log(await user?.getIdToken() ?? '');
  }

  String getUserID() {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  final Dio _dio = Dio();
  Future doGet({String? endp, Object? obj}) async {}

  Future<Response> doPost({required String url, required data}) async {
    try {
      await setDio(_dio);
      print(url);
      print(data);
      return await _dio.post(url, data: data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> doDelete({required String url}) async {
    try {
      await setDio(_dio);
      print(url);
      return await _dio.delete(url);
    } catch (e) {
      throw Exception(e);
    }
  }







  
}




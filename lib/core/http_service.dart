// ignore_for_file: constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:xplore/core/config.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class HttpService {
  final Dio _dio = Dio();
  var logger = Logger();

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

  static header() => {"Content-Type": "application/json"};

  Future<HttpService> init() async {
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          //logger.i("REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}" "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          //logger.i("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (err, handler) {
          //logger.i("Error[${err.response?.statusCode}]");
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request(
      {required String url, required Method method, params}) async {
    Response response;
    initInterceptors();
    try {
      await setDio(_dio);
      if (method == Method.POST) {
        response = await _dio.post(url, data: params);
      } else if (method == Method.DELETE) {
        response = await _dio.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio.patch(url, data: params);
      } else {
        response = await _dio.get(url /*, queryParameters: params*/);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something does wen't wrong");
      }
    } on SocketException catch (e) {
      logger.e(e);
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      logger.e(e);
      throw Exception("Bad response format");
    } on DioError catch (e) {
      logger.e(e);
      throw Exception(e);
    } catch (e) {
      logger.e(e);
      throw Exception("Something wen't wrong");
    }
  }
}

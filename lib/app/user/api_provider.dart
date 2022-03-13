import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:xplore/app/user/user_model.dart';
import 'package:xplore/core/repository.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');

class UserApiProvider extends Repository {
  final Dio _dio = Dio();
  final String _url = 'http://128.1.152.38:8082/api/pg/workareas';

  Future<List<UserModel>> fetchUserList() async {
    String endpoint = "";

    await setDio(_dio);

    String url = conf.ip + "user";
    log(url);
    // try {
    //await Future.delayed(Duration(seconds: 3));
    Response response = await _dio.post(url);
    // return UserModel(name: "name", surname: "surname", badge: 1, id: "id", option: "option", resp: true, visible: true);
    log(UserModel.fromJson(response.data[0]).toString());
    List<UserModel> _usr = [];
    response.data.forEach((v) {
      _usr.add(UserModel.fromJson(v));
    });
    return _usr;
    /*} catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
     // return UserModel.withError("Data not found / Connection issue");
    }*/
  }

  Future<bool> addUserList(String name) async {
    try {
      //await Future.delayed(Duration(seconds: 3));
      Response response = await _dio.get(_url);
      debugPrint("okay");
      addItem(title: "tit", description: "desc");
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }

  static Future<void> addItem({
    required String title,
    required String description,
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }
}

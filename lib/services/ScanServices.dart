import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/services/API.dart';

class ScanService {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> getScanByUser(

      String user, String QDcode, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw +
        "/api/Operation/getFiltredReservation/" +
        user +
        "/" +
        QDcode,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*
    Response res = await get(
      Uri.parse(link.linkw +
          "/api/Operation/getFiltredReservation/" +
          user +
          "/" +
          QDcode),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getAccesScan(String user, String QDcode, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw +
        "/api/reservation/getDeskAccess/" +
        user +
        "/" +
        QDcode,options: Dio.Options(
        headers: {
          'x-access-token': token,
        }
    ));
    //dynamic body = jsonDecode(response);
    print("response operation"+response.data.toString());

    return response.data;
/*    Response res = await get(
        Uri.parse(link.linkw +
            "/api/reservation/getDeskAccess/" +
            user +
            "/" +
            QDcode),
        headers: <String, String>{
          'x-access-token': token,
        });
    dynamic body = jsonDecode(res.body);
    return body;*/
  }
}

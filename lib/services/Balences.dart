import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/services/API.dart';

class BalenceServices {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();
  Future<dynamic> getUserBalences(String User, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.get(link.linkw + "/api/Balance/getUserBalance/" + User,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    return response.data;

/*    Response res = await get(
      Uri.parse(link.linkw + "/api/Balance/getUserBalance/" + User),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getSettingsBalences(String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.get(link.linkw + "/api/Setting/getSettingsName/" + "WFH_Balance",
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    return response.data;

/*    Response res = await get(
      Uri.parse(link.linkw + "/api/Setting/getSettingsName/" + "WFH_Balance"),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }
}

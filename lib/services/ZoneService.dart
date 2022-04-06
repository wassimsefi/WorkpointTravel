import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/services/API.dart';

class ZoneService {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> getZoneByUser(String user, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/Zone/getAcesszone/" + user,options: Dio.Options(
        headers: {
          'x-access-token': token,
        }
    ));
    //dynamic body = jsonDecode(response);

    return response.data;
/*    Response res = await get(
      Uri.parse(link.linkw + "/api/Zone/getAcesszone/" + user),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getZoneBymap(String user, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/Zone/getMapAccess/" + user,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
      Uri.parse(link.linkw + "/api/Zone/getMapAccess/" + user),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }
}

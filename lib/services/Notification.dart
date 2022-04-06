import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/services/API.dart';

class NotificationServices {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> getUserNotifications(String User, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.get(link.linkw + "/api/notification/getNotificationByUser/" + User,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;

/*    Response res = await get(Uri.parse(link.linkw + "/api/notification/getNotificationByUser/" + User),
      headers: <String, String>{
        'x-access-token': tokenLogin,
      },);
    dynamic body;
    if (res.body.toString() == "jwt expired" ||
        res.body.toString() == "jwt malformed" ||
        res.body.toString() == "invalid signature") {
      body = "jwt expired";
    } else {
      body = jsonDecode(res.body);
    }
    return body;*/
  }
}

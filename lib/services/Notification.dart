import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/models/Notification.dart';
import 'package:vato/services/API.dart';

class NotificationServices {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> getUserNotifications(String User, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.get(
        link.linkw + "/api/notification/getNotificationByUser/" + User,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
  }

  Future<dynamic> addNotification(
      Notifications notification, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.post(link.linkw + "/api/notification/addNotification",
        data: json.encode(notification),
        options: Dio.Options(headers: {
          //   'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
  }
}

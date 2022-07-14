import 'dart:convert';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/models/Historique.dart';
import 'package:vato/services/API.dart';

class HistoryService {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();
  Future<dynamic> getHistopryByUser(String user, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/History/cardhistory/" + user,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());

    return response.data;
  }

  Future<dynamic> addNotification(
      Historique historique, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.post(link.linkw + "/api/History/add",
        data: json.encode(historique),
        options: Dio.Options(headers: {
          //   'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
  }
}

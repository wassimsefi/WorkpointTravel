import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/models/Alfresco.dart';
import 'package:vato/models/Mission.dart';
import 'package:vato/services/API.dart';

class AlfrescoService {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> getAddDoc(dynamic test) async {
    //final token = await _storage.read(key: 'token');
    response = await dio.post(
        "http://192.168.100.58:8087/alfresco/s/api/upload?alf_ticket=TICKET_648b4d9c6c3ce631fa5a7f56726189272c289304",
        data: test,
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response alfresco" + response.data.toString());

    return response.data;
  }

  Future<dynamic> getDoc() async {
    //final token = await _storage.read(key: 'token');
    response = await dio.get(
        "http://192.168.100.58:8087/alfresco/s/slingshot/node/content/workspace/SpacesStore/9fed8eea-9459-4a2b-a0d2-c0af8c527904?a=true&alf_ticket=TICKET_648b4d9c6c3ce631fa5a7f56726189272c289304",
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response alfresco" + response.data.toString());

    return response.data;
  }
}

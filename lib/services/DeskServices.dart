import 'dart:convert';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/services/API.dart';

class DeskServices {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();
  Future<dynamic> getDeskById(String desk, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.get(link.linkw + "/api/desk/search/" + desk,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;

/*    Response res = await get(Uri.parse(link.linkw + "/api/desk/search/" + desk),
        headers: <String, String>{
          'x-access-token': token,
        });
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> DesksAvailability(
      String zone, String date, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.get(link.linkw + "/api/Zone/getdesksavailibility/" + zone + "/" + date,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
        Uri.parse(
            link.linkw + "/api/Zone/getdesksavailibility/" + zone + "/" + date),
        headers: <String, String>{
          'x-access-token': token,
        });
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getDeskAvailability(

      String id, String date, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.get(link.linkw + "/api/availability/search/" + id + "/" + date,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
        Uri.parse(link.linkw + "/api/availability/search/" + id + "/" + date),
        headers: <String, String>{
          'x-access-token': token,
        });
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getAvailability(
      String id, String date, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.get(link.linkw + "/api/availability/searchAV/" + id + "/" + date,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    return response.data;
/*    Response res = await get(
        Uri.parse(link.linkw + "/api/availability/searchAV/" + id + "/" + date),
        headers: <String, String>{
          'x-access-token': token,
        });
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> FreeSpot(String startDate, String EndDate, String idSpot,
      String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.post(link.linkw + "/api/availability/UpdatedAvailibilityParking",
        data:jsonEncode(<String, dynamic>{
          "status": true,
          "id": idSpot,
          "startDate": startDate,
          "EndDate": EndDate
        }),
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    return response.data;
/*    Response res = await post(
        Uri.parse(link.linkw + "/api/availability/UpdatedAvailibilityParking"),
        headers: <String, String>{
          'x-access-token': token,
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "status": true,
          "id": idSpot,
          "startDate": startDate,
          "EndDate": EndDate
        }));
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> CancelFreeSpot(String idSpot, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.get(link.linkw + "/api/availability/CancelFreeParking/" + idSpot,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*
    Response res = await get(
      Uri.parse(link.linkw + "/api/availability/CancelFreeParking/" + idSpot),
      headers: <String, String>{
        'x-access-token': token,
        "Content-Type": "application/json"
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }
}

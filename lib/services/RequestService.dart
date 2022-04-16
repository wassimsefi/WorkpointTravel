import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/models/Request.dart';
import 'package:vato/services/API.dart';

class RequestService {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> addRequest(Requests request, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.post(link.linkw + "/api/Request/addRequest",
        data: json.encode(request),
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    print("response operation" + response.data.toString());
    return response.data;
  }

  Future<dynamic> getRequestByUser(String user, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response =
        await dio.get(link.linkw + "/api/Request/getRequestsByUser/" + user,
            options: Dio.Options(headers: {
              //  'x-access-token': token,
            }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
        Uri.parse(link.linkw + "/api/Request/getRequestsByUser/" + user),
        headers: <String, String>{
          'x-access-token': token,
        });
    dynamic body = jsonDecode(res.body);
    // List<CardReservations> posts = List<CardReservations>.from(body.map((model)=> CardReservations.fromJsonMap(model)));

    return body;*/
  }

  Future<dynamic> getRequestByManager(String user, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(
        link.linkw + "/api/Request/getPendingRequestsByManager/" + user,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
        Uri.parse(
            link.linkw + "/api/Request/getPendingRequestsByManager/" + user),
        headers: <String, String>{
          'x-access-token': token,
        });
    dynamic body = jsonDecode(res.body);
    // List<CardReservations> posts = List<CardReservations>.from(body.map((model)=> CardReservations.fromJsonMap(model)));

    return body;*/
  }

  Future<dynamic> ValidateRequet(String requets, String Status,
      String commentManager, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    dynamic Response;
    if (commentManager.isEmpty == true) {
      response =
          await dio.put(link.linkw + "/api/Request/updateRequest/" + requets,
              data: jsonEncode(<String, String>{
                // "id":requets,
                'status': Status,
              }),
              options: Dio.Options(headers: {
                'x-access-token': token,
              }));
      //dynamic body = jsonDecode(response);
      print("response operation" + response.data.toString());

/*      Response = await put(
        Uri.parse(link.linkw + "/api/Request/updateRequest/" + requets),
        body: jsonEncode(<String, String>{
          // "id":requets,
          'status': Status,
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'x-access-token': token
        },
      );*/
    } else {
      response =
          await dio.put(link.linkw + "/api/Request/updateRequest/" + requets,
              data: jsonEncode(<String, String>{
                // "id":requets,
                'status': Status,
                "commentManager": commentManager
              }),
              options: Dio.Options(headers: {
                'x-access-token': token,
              }));
      //dynamic body = jsonDecode(response);
      print("response operation" + response.data.toString());

/*      Response = await put(
        Uri.parse(link.linkw + "/api/Request/updateRequest/" + requets),
        body: jsonEncode(<String, String>{
          // "id":requets,
          'status': Status,
          "commentManager": commentManager
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'x-access-token': token
        },
      );*/
    }

    // If the server did return a 200 UPDATED response,
    // then parse the JSON.
    return response.data;
  }

  Future<dynamic> CancelRequet(String request, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response =
        await dio.delete(link.linkw + "/api/Request/cancelRequest/" + request,
            options: Dio.Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'x-access-token': token,
            }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    final Response response = await delete(
      Uri.parse(link.linkw + "/api/Request/cancelRequest/" + request),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token
      },
    );
    // If the server did return a 200 UPDATED response,
    // then parse the JSON.
    return jsonDecode(response.body);*/
  }
}

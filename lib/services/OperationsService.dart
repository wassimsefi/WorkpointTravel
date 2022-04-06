import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/models/Reservations.dart';
import 'package:vato/services/API.dart';

class OperationService {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> getOperationsbyRequest(

      String request, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/Operation/getOperationsByRequest/" + request,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
        Uri.parse(
            link.linkw + "/api/Operation/getOperationsByRequest/" + request),
        headers: <String, String>{
          'x-access-token': token,
        });
    dynamic body = jsonDecode(res.body);
    // List<CardReservations> posts = List<CardReservations>.from(body.map((model)=> CardReservations.fromJsonMap(model)));

    return body;*/
  }

  Future<dynamic> getOperationsbyUser(String idUser, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

//print("tokenjdid"+token.toString());
    response = await dio.get(link.linkw + "/api/Operation/getOperationsByUser/" + idUser,options: Dio.Options(
        headers: {
          'x-access-token': token,
        }
    ));
   //dynamic body = jsonDecode(response);
    print("response operation"+response.data.toString());

    return response.data;
    print("tttttttttttttttt"+response.data.toString());
/*    Response res = await get(
        Uri.parse(link.linkw + "/api/Operation/getOperationsByUser/" + idUser),
        headers: <String, String>{
          'x-access-token': tokenLogin,
        });
    dynamic body;
    if (res.body.toString() == "jwt expired" ||
        res.body.toString() == "jwt malformed" ||
        res.body.toString() == "invalid signature") {
      body = "jwt expired";
    } else {
      body = jsonDecode(res.body);
      // List<CardReservations> posts = List<CardReservations>.from(body.map((model)=> CardReservations.fromJsonMap(model)));
    }
    return body;*/
  }

  Future<dynamic> CancelOperation(
      String operation_id, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.delete(link.linkw + "/api/Operation/deleteOperation/" + operation_id,
        options: Dio.Options(headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    final Response response = await delete(
      Uri.parse(link.linkw + "/api/Operation/deleteOperation/" + operation_id),
      //
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

  Future<dynamic> checkoutParking(String id) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/Operation/checkoutParking/" + id,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
      Uri.parse(link.linkw + "/api/Operation/checkoutParking/" + id),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token

      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> AddNewReservation(Reservations reservation,
      String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.post(link.linkw + "/api/Operation/addNewReservation",
        data: jsonEncode(reservation),
        options: Dio.Options(headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*
    Response res = await post(
      Uri.parse(link.linkw + "/api/Operation/addNewReservation"),
      body: jsonEncode(reservation),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> AddNewReservations(
      List<Reservations> reservation, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.post(link.linkw + "/api/Operation/addNewReservations",
        data: jsonEncode(reservation),
        options: Dio.Options(
            headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await post(
      Uri.parse(link.linkw + "/api/Operation/addNewReservations"),
      body: jsonEncode(reservation),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getOperationsByManager(String user, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw +  "/api/Operation/getOperationsByManager/" + user,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    final Response response = await get(
      Uri.parse(link.linkw + "/api/Operation/getOperationsByManager/" + user),
      //
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

  Future<dynamic> checkAvailibility(String user, String reservationDate,
      String timeslot, String resource, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw +
        "/api/Operation/checkReservation/" +
        user +
        "/" +
        reservationDate +
        "/" +
        timeslot +
        "/" +
        resource,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
        Uri.parse(link.linkw +
            "/api/Operation/checkReservation/" +
            user +
            "/" +
            reservationDate +
            "/" +
            timeslot +
            "/" +
            resource),
        headers: <String, String>{
          'x-access-token': token,
        });
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> ScanDesk(
      String user, String QDcode, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/Operation/ScanQR/" + user + "/" + QDcode,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
      Uri.parse(link.linkw + "/api/Operation/ScanQR/" + user + "/" + QDcode),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    dynamic body = jsonDecode(res.body);
    // List<CardReservations> posts = List<CardReservations>.from(body.map((model)=> CardReservations.fromJsonMap(model)));
    return body;*/
  }
}

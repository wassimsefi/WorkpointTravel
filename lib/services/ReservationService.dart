import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/models/Reservations.dart';
import 'package:vato/services/API.dart';

class ReservationService {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> checkAvailibility(String user, String reservationDate,
      String timeslot, String resource, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.get(link.linkw +
        "/api/reservation/checkreservation/" +
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
            "/api/reservation/checkreservation/" +
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


  Future<dynamic> CancelNotifParking(String idReservation, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.post(link.linkw + "/api/reservation/updateParking",
        data:json.encode(idReservation),
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await post(
      Uri.parse(link.linkw + "/api/reservation/updateParking"),
      body: json.encode(idReservation),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token
      },
    );

    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> checkoutParking(var reservationParking, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.post(link.linkw + "/api/reservation/checkOut",
        data:json.encode(reservationParking),
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await post(
      Uri.parse(link.linkw + "/api/reservation/checkOut"),
      body: json.encode(reservationParking),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token
      },
    );

    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getZonesAV(var data, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.post(link.linkw + "/api/reservation/getAVZones",
        data: json.encode(data),
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await post(
      Uri.parse(link.linkw + "/api/reservation/getAVZones"),
      body: json.encode(data),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token
      },
    );

    dynamic body = jsonDecode(res.body);

    return body;*/
  }
}

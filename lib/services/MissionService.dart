import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/services/API.dart';

class MissionService {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> getAllMissionObject() async {
    //final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/ObjetMission/",
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());

    return response.data;
  }

  Future<dynamic> getAllMissionFormula() async {
    //final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/Formula/",
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());

    return response.data;
  }

  Future<dynamic> getAllHotel() async {
    //final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/Hotel/",
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());

    return response.data;
  }

  Future<dynamic> getAllCountry() async {
    //final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/Country/all",
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());

    return response.data;
  }

  Future<dynamic> getCountryNyName(pays) async {
    //final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/Country/getId/" + pays,
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());

    return response.data;
  }

  Future<dynamic> getCiteByCountry(id) async {
    //final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/City/search/country/" + id,
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());

    return response.data;
  }

  Future<dynamic> getVaccine() async {
    //final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/Vaccine/",
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());

    return response.data;
  }

  Future<dynamic> getVisaById(id) async {
    //final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/Visa/search/" + id,
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());

    return response.data;
  }

  Future<dynamic> getCityCapByCountry(id) async {
    //final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/CityCap/getIdByCountry/" + id,
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());

    return response.data;
  }

  Future<dynamic> getCityCapById(id) async {
    //final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/CityCap/search/" + id,
        options: Dio.Options(headers: {
          //  'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());

    return response.data;
  }
}

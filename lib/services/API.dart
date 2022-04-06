

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/constants/link.dart';

class API {
  final Dio api = Dio();
  String accessToken;
  final _storage = const FlutterSecureStorage();

  Dio Api() {
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.path.contains('http')) {
        options.path = link.linkw+ options.path;
      }
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      if ((error.response?.statusCode == 401)) {
        // print("dddddddiiiiiioooooooo"+error.response.toString());

        // will throw error below
        if (await _storage.containsKey(key: 'refreshToken')) {
          final ref = await _storage.read(key: 'refreshToken');

          Map<String, dynamic> payload = Jwt.parseJwt(
            ref.toString(),
          );
          // print("reeeeeeeefffffff"+payload.toString());

          await refreshToken();
          error.requestOptions.headers= { 'x-access-token': accessToken,
          };
          return handler.resolve(await _retry(error.requestOptions));
        }else{
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          final _storage = const FlutterSecureStorage();
          await _storage.deleteAll();
        }

      }
      return handler.next(error);
    }));
    return api;
  }

  Future<void> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');

    //print("reeeeeeeeessssss"+refreshToken);

    final response = await api
        .post('/api/User/auth/refresh', data: {'refreshToken': refreshToken});

    if (response.statusCode == 200) {
      // successfully got the new access token
      accessToken = response.data["token"];
      Map<String, dynamic> payload = Jwt.parseJwt(
        accessToken.toString(),
      );
      print("token jdid fil refresh"+response.data.toString()+"firas");

      await _storage.write(key: "token", value: accessToken.toString());
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      Map<String, dynamic> tokenDecoded = Jwt.parseJwt(
        accessToken.toString(),
      );
      final SharedPreferences prefs = await _prefs;
      prefs.setString("role", tokenDecoded["role"].toString()).then((bool success) {
        return tokenDecoded["role"];
      });
      prefs.setString("spot", tokenDecoded["spot"].toString()).then((bool success) {
        return tokenDecoded["spot"];
      });
    } else {
      // refresh token is wrong so log out user.
/*      accessToken = null;
      _storage.deleteAll();*/
    }
  }
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    print("headers retrys"+requestOptions.headers.toString()) ;
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }


/*
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
*/
}

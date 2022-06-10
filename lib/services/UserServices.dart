import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/services/API.dart';
import 'package:vato/models/User.dart';

class UserService {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();
  Future<dynamic> login(User user) async {
    Response res = await post(Uri.parse(link.linkw + "/api/User/login"),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(user));
    dynamic body = jsonDecode(res.body);
    return body;
  }

  Future<dynamic> updatepassword(String user, String oldpassword,
      String newpassword, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.put(link.linkw + "/api/User/updatemyprofile/" + user,
        data: jsonEncode(<String, String>{
          'newpassword': newpassword,
          'oldpassword': oldpassword,
        }),
        options: Dio.Options(headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    final Response response = await put(
      Uri.parse(link.linkw + "/api/User/updatemyprofile/" + user),
      body: jsonEncode(<String, String>{
        'newpassword': newpassword,
        'oldpassword': oldpassword,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token
      },
    );*/
    // If the server did return a 200 UPDATED response,
    // then parse the JSON.
    //return jsonDecode(response.body);
  }

  Future<dynamic> getUserFromLogin(String login, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/getuserfromlogin/" + login,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
      Uri.parse(link.linkw + "/getuserfromlogin/" + login),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getUsers(String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/User/getUsers",
        options: Dio.Options(headers: {
          //   'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
      Uri.parse(link.linkw + "/api/User/getUsers"),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getUserProfil(String iduser, String tokenLogin) async {
    final token = await _storage.read(key: 'token');

    response = await dio.get(link.linkw + "/api/User/search/" + iduser,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
      Uri.parse(link.linkw + "/api/User/search/" + iduser),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
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

  Future<dynamic> getStatRes(
      String id, String datestart, String dateend, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(
        link.linkw +
            "/api/User/nbofreservations/" +
            id +
            "/" +
            dateend +
            "/" +
            datestart,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
      Uri.parse(link.linkw +
          "/api/User/nbofreservations/" +
          id +
          "/" +
          dateend +
          "/" +
          datestart),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getStatCheckin(
      String id, String datestart, String dateend, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(
        link.linkw +
            "/api/User/nbofchekins/" +
            id +
            "/" +
            dateend +
            "/" +
            datestart,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
      Uri.parse(link.linkw +
          "/api/User/nbofchekins/" +
          id +
          "/" +
          dateend +
          "/" +
          datestart),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getStatCancel(
      String id, String datestart, String dateend, String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(
        link.linkw +
            "/api/User/nbofcancellations/" +
            id +
            "/" +
            dateend +
            "/" +
            datestart,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
      Uri.parse(link.linkw +
          "/api/User/nbofcancellations/" +
          id +
          "/" +
          dateend +
          "/" +
          datestart),
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> forgotpassword(dynamic email, String validationCode) async {
    Response res = await post(Uri.parse(link.linkw + "/api/user/forgotPasswd"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          'Email': email,
          'ValidationCoDE': validationCode
        }));
    dynamic body = jsonDecode(res.body);
    return body;
  }

  Future<dynamic> newpassword(String password, String id) async {
    Response res =
        await post(Uri.parse(link.linkw + "/api/user/NewPasswd/" + id),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(<String, String>{
              'password': password,
            }));
    dynamic body = jsonDecode(res.body);
    return body;
  }

  Future<dynamic> getMangers(String tokenLogin) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/user/getValidators/",
        options: Dio.Options(headers: {
          // 'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(Uri.parse(link.linkw + "/api/user/getValidators/"),
        headers: <String, String>{
          'x-access-token': token,
        });

    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> getTeamManager(String tokenLogin, String User) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/user/getTeamManager/" + User,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
        Uri.parse(link.linkw + "/api/user/getTeamManager/" + User),
        headers: <String, String>{
          'x-access-token': token,
        });

    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> Get_NBR_Reservation(
      String tokenLogin, String User, String startDate, String endDate) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(
        link.linkw +
            "/api/user/nbofreservations/" +
            User +
            "/" +
            startDate +
            "/" +
            endDate,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
        Uri.parse(link.linkw +
            "/api/user/nbofreservations/" +
            User +
            "/" +
            startDate +
            "/" +
            endDate),
        headers: <String, String>{
          'x-access-token': token,
        });

    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> Get_NBR_WFH(
      String tokenLogin, String User, String startDate, String endDate) async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(
        link.linkw +
            "/api/user/nbofwfh/" +
            User +
            "/" +
            startDate +
            "/" +
            endDate,
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
/*    Response res = await get(
        Uri.parse(link.linkw +
            "/api/user/nbofwfh/" +
            User +
            "/" +
            startDate +
            "/" +
            endDate),
        headers: <String, String>{
          'x-access-token': token,
        });

    dynamic body = jsonDecode(res.body);
    return body;*/
  }

  Future<dynamic> updateVisa(
      String visa, String date, String idImage, String user) async {
    final token = await _storage.read(key: 'token');
    response = await dio.put(link.linkw + "/api/User/UpdateVisa/" + user,
        data: jsonEncode(<String, String>{
          'id': visa,
          'expiryDate': date,
          "idImage": idImage
        }),
        options: Dio.Options(headers: {
          //   'x-access-token': token,
        }));
    //dynamic body = jsonDecode(response);
    print("response operation" + response.data.toString());
    return response.data;
  }
}

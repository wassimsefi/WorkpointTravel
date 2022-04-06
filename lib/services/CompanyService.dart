import 'dart:convert';
import 'package:http/http.dart';
import 'package:vato/constants/link.dart';

class CompanyService {

  Future<dynamic> getCompany(String ValidatorCode) async {

    Response res = await get(Uri.parse("http://192.168.1.16:3000/api/Client/getId/"+ValidatorCode),
        headers: {"Content-Type": "application/json"}, );
    dynamic body = jsonDecode(res.body);
    return body;
  }
}
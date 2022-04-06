import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/services/API.dart';

class BuildingService {
  Dio.Response response;
  var dio = API().Api();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> getBuildingResources() async {
    final token = await _storage.read(key: 'token');
    response = await dio.get(link.linkw + "/api/building/",
        options: Dio.Options(headers: {
          'x-access-token': token,
        }));
    print("response Building" + response.data.toString());

    return response.data;
  }
}

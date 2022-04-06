
import 'package:vato/models/Access.dart';
import 'package:vato/models/Grades.dart';
import 'package:vato/models/ServicesLines.dart';
import 'package:vato/models/SubServiceLines.dart';
import 'package:vato/models/User.dart';
import 'package:vato/models/Zone.dart';
class ServiceLines {

  int id;
  String serviceLine;
  User Users;
  SubServiceLines subserviceLine;
  Access acess;




  ServiceLines.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        serviceLine = map["serviceLine"],
        Users = map["Users"],
        subserviceLine = map["subserviceLine"],
        acess = map["Acess"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data["serviceLine"] = serviceLine;
    data["Users"] = Users ;
    data["subserviceLine"] =  subserviceLine ;
    data["Acess"] = acess ;
    return data;
  }

  ServiceLines();
}






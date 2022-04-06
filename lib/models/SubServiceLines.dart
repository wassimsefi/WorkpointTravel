
import 'package:vato/models/Access.dart';
import 'package:vato/models/Grades.dart';
import 'package:vato/models/ServicesLines.dart';
import 'package:vato/models/SubServiceLines.dart';
import 'package:vato/models/User.dart';
import 'package:vato/models/Zone.dart';
class SubServiceLines {

  int id;
  String subserviceLine;
  ServiceLines serviceLine;
  Access acess;




  SubServiceLines.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        subserviceLine = map["subserviceLine"],
        serviceLine = map["serviceLine"],
        acess = map["Acess"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data["subserviceLine"] = subserviceLine;
    data["serviceLine"] =  serviceLine ;
    data["Acess"] = acess ;
    return data;
  }

  SubServiceLines();
}







import 'package:vato/models/Access.dart';

class Grades {

  int id;
  String grade_name;
  Access access;




  Grades.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        access = map["Accesses"],
        grade_name = map["grade_name"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data["Accesses"] = access;
    data["grade_name"] = grade_name ;

    return data;
  }

  Grades();
}






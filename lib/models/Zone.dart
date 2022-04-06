
import 'package:vato/models/Access.dart';
import 'package:vato/models/Desk.dart';
import 'package:vato/models/Floor.dart';


class Zone {

  int id;
  String status;
  Floor floor;
  int NumberDesks;
  int NumberBookedDesks;
  int NumberFreeDesks;
  Desk Desks;
  Access Accesses;





  Zone.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        status = map["status"],
        floor = map["floor"],
        NumberDesks = map["NumberDesks"],
        NumberBookedDesks = map["NumberBookedDesks"],
        NumberFreeDesks = map["NumberFreeDesks"],
        Desks = map["Desks"],
        Accesses = map["Accesses"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data["status"] = status ;
    data["floor"] = floor;
    data["NumberDesks"] = NumberDesks;
    data["NumberBookedDesks"] = NumberBookedDesks;
    data["NumberFreeDesks"] =  NumberFreeDesks ;
    data["Desks"] = Desks ;
    data["Accesses"] = Accesses;
    return data;
  }

  Zone();
}








import 'package:vato/models/Building.dart';
import 'package:vato/models/Zone.dart';
class Floor {

  int id;
  String name;
  Building building;
  Zone zones;




  Floor.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        name = map["name"],
        building = map["building"],
        zones = map["zones"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data["name"] = name;
    data["building"] =  building ;
    data["zones"] = zones ;
    return data;
  }

  Floor();
}






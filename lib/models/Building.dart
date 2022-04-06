
import 'package:vato/models/Floor.dart';
class Building {

  int id;
  String adress;
  Floor floors;



  Building.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        adress = map["adress"],
        floors = map["floors"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data["adress"] = adress;
    data["floors"] =  floors ;
    return data;
  }

  Building();
}






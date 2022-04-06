
import 'package:vato/models/Reservations.dart';
import 'package:vato/models/Zone.dart';

class Desk {

  String id;
  String Status;
  String QrCode;
  Zone zone;
  bool isAvailable;
  Reservations reservation;

  Desk.fromJsonMap(Map<String, dynamic> map):
        id = map["_id"],
        Status = map["Status"],
        QrCode = map["QrCode"],
        zone = map["Zones"],
        isAvailable = map["isAvailable"],
        reservation = map["reservation"];
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data["Status"] = Status;
    data["QrCode"] = QrCode ;
    data["Zones"] =  zone ;
    data["isAvailable"] = isAvailable ;
    data["reservation"] = reservation;

    return data;
  }

  Desk();
}






class DeskReservation {

  String id;




  DeskReservation.fromJsonMap(Map<String, dynamic> map):
        id = map["_id"];
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;

    return data;
  }

  DeskReservation();}


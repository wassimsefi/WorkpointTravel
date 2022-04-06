
class CardReservations {

  int id;
  String desk;
  String zone;
  String floor;
  String time;
  String slot;
CardReservations ({this.id,this.desk,this.zone,this.floor,this.time,this.slot});
  factory CardReservations.fromJsonMap(Map <String,dynamic>json){
    return CardReservations(
        id : json["id"],
        desk :json["desk"],
        zone : json["zone"],
        floor : json["floor"],
        time : json["time"],
        slot : json["slot"],
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data["desk"] = desk;
    data["zone"] = zone ;
    data["floor"] =  floor ;
    data["time"] = time ;
    data["slot"] = slot ;

    return data;
  }

}






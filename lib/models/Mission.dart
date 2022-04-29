class Missions {
  String title;
  String MissionFormula;
  String MissionObjet;
  String partner;
  String manager;
  String dateDebut;
  String dateFinal;
  String perdiem;
  double amount;
  String comment;
  bool needTransport;
  bool allerRetour;
  String departureCountryAller;
  String departureCityAller;
  String destinationCountryAller;
  String destinationCityAller;
  String hotel;
  int rateHotelMax;
  double longitude;
  double altitude;
  String validtePassport;
  String visa;
  bool obtenirVisa;
  String departureCountryRetour;
  String departureCityRetour;
  String destinationCountryRetour;
  String destinationCityRetour;

  List<Map<dynamic, dynamic>> documents_visa = [];
  List<Map<dynamic, dynamic>> vaccin = [];

  Missions.fromJsonMap(Map<String, dynamic> map)
      : title = map["title"],
        MissionFormula = map["MissionFormula"],
        MissionObjet = map["MissionObjet"],
        partner = map["partner"],
        manager = map["manager"],
        dateDebut = map["dateDebut"],
        dateFinal = map["dateFinal"],
        perdiem = map["perdiem"],
        amount = map["amount"],
        comment = map["comment"],
        needTransport = map["needTransport"],
        allerRetour = map["allerRetour"],
        departureCountryAller = map["departureCountryAller"],
        departureCityAller = map["departureCityAller"],
        destinationCountryAller = map["destinationCountryAller"],
        destinationCityAller = map["destinationCityAller"],
        hotel = map["hotel"],
        rateHotelMax = map["rateHotelMax"],
        longitude = map["longitude"],
        altitude = map["rateHotelMax"],
        validtePassport = map["validtePassport"],
        visa = map["visa"],
        obtenirVisa = map["obtenirVisa"],
        documents_visa = map["documents_visa"],
        vaccin = map["vaccin"],
        destinationCityRetour = map["destinationCityRetour"],
        destinationCountryRetour = map["destinationCountryRetour"],
        departureCityRetour = map["departureCityRetour"],
        departureCountryRetour = map["departureCountryRetour"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["title"] = title;
    data["MissionFormula"] = MissionFormula;
    data["MissionObjet"] = MissionObjet;
    data["partner"] = partner;
    data["manager"] = manager;
    data["dateDebut"] = dateDebut;
    data["dateFinal"] = dateFinal;
    data["perdiem"] = perdiem;
    data["amount"] = amount;
    data["comment"] = comment;
    data["needTransport"] = needTransport;
    data["allerRetour"] = allerRetour;
    data["departureCountryAller"] = departureCountryAller;
    data["departureCityAller"] = departureCityAller;
    data["destinationCountryAller"] = destinationCountryAller;
    data["destinationCityAller"] = destinationCityAller;

    data["hotel"] = hotel;
    data["rateHotelMax"] = rateHotelMax;
    data["longitude"] = longitude;
    data["altitude"] = altitude;
    data["validtePassport"] = validtePassport;
    data["visa"] = visa;
    data["obtenirVisa"] = obtenirVisa;
    data["documents_visa"] = documents_visa;
    data["vaccin"] = vaccin;
    data["destinationCityRetour"] = destinationCityRetour;

    data["destinationCountryRetour"] = destinationCountryRetour;

    data["departureCityRetour"] = departureCityRetour;

    data["departureCountryRetour"] = departureCountryRetour;
    return data;
  }

  Missions();
}

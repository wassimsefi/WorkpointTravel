import 'dart:ffi';

import 'package:vato/models/Floor.dart';

class Missions {
  String title;
  String MissionFormula;
  String MissionObjet;
  String partner;
  String manager;
  String user;

  String dateDebut;
  String dateFinal;
  String perdiem;
  double amount;
  String expensesComment;
  String transportationComment;

  bool needTransport;
  bool allerRetour;
  String departureCountryAller;
  String departureCityAller;
  String destinationCountryAller;
  String destinationCityAller;
  String hotel;
  String rateHotelMax;
  double longitude;
  double altitude;
  String validtePassport;
  String visa;
  bool obtenirVisa;
  String missionCountry;
  String missionCity;

  List<Map<dynamic, dynamic>> documents_visa = [];
  List<Map<dynamic, dynamic>> vaccin = [];

  Missions.fromJsonMap(Map<String, dynamic> map)
      : title = map["title"],
        MissionFormula = map["MissionFormula"],
        MissionObjet = map["MissionObjet"],
        partner = map["partner"],
        manager = map["manager"],
        dateDebut = map["startDate"],
        dateFinal = map["endDate"],
        perdiem = map["perdiem"],
        amount = map["extraExpenses"],
        expensesComment = map["expensesComment"],
        transportationComment = map["transportationComment"],
        needTransport = map["needTransportation"],
        allerRetour = map["roundTrip"],
        departureCountryAller = map["onewayDepartureCountry"],
        departureCityAller = map["onewayDepartureCity"],
        destinationCountryAller = map["onewayDestinationCountry"],
        destinationCityAller = map["onewayDestinationCity"],
        hotel = map["transportationComment"],
        rateHotelMax = map["cityCap"],
        longitude = map["longitude"],
        altitude = map["altitude"],
        validtePassport = map["validtePassport"],
        visa = map["visa"],
        obtenirVisa = map["getVisa"],
        documents_visa = map["visaDocuments"],
        vaccin = map["vaccines"],
        missionCountry = map["missionCountry"],
        missionCity = map["MissionCity"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["title"] = title;
    data["MissionFormula"] = MissionFormula;
    data["MissionObjet"] = MissionObjet;
    data["partner"] = partner;
    data["manager"] = manager;
    data["startDate"] = dateDebut;
    data["endDate"] = dateFinal;
    data["perdiem"] = perdiem;
    data["extraExpenses"] = amount;
    data["expensesComment"] = expensesComment;
    data["transportationComment"] = transportationComment;

    data["needTransportation"] = needTransport;
    data["roundTrip"] = allerRetour;
    data["onewayDepartureCountry"] = departureCountryAller;
    data["onewayDepartureCity"] = departureCityAller;
    data["onewayDestinationCountry"] = destinationCountryAller;
    data["onewayDestinationCity"] = destinationCityAller;

    data["accomodationComment"] = hotel;
    data["cityCap"] = rateHotelMax;
    data["longitude"] = longitude;
    data["altitude"] = altitude;
    data["validtePassport"] = validtePassport;
    data["visa"] = visa;
    data["getVisa"] = obtenirVisa;
    data["visaDocuments"] = documents_visa;
    data["vaccines"] = vaccin;
    data["missionCountry"] = missionCountry;

    data["missionCity"] = missionCity;

    return data;
  }

  Missions();
}

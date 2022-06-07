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
  Expenses expenses;
  Transportations transportations;

  Accomodations accomodations;
  Visas visas;
  Vaccines vaccines;
  StepPartener stepPartener;
  StepManager stepManager;
  Missions.fromJsonMap(Map<String, dynamic> map)
      : title = map["title"],
        MissionFormula = map["Formula"],
        MissionObjet = map["MissionObjet"],
        partner = map["partner"],
        manager = map["manager"],
        dateDebut = map["startDate"],
        dateFinal = map["endDate"],
        expenses = map['expenses'] != null
            ? new Expenses.fromJsonMap(map['expenses'])
            : null,
        transportations = map['transportation'] != null
            ? new Transportations.fromJsonMap(map['transportation'])
            : null,
        accomodations = map['accomodation'] != null
            ? new Accomodations.fromJsonMap(map['accomodation'])
            : null,
        visas = map['visa'] != null ? new Visas.fromJsonMap(map['visa']) : null,
        stepPartener = new StepPartener.fromJsonMap(map['stepPartener']),
        stepManager = new StepManager.fromJsonMap(map['stepManager']),
        vaccines = map['vaccine'] != null
            ? new Vaccines.fromJsonMap(map['visa'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["title"] = title;
    data["Formula"] = MissionFormula;
    data["MissionObjet"] = MissionObjet;
    data["partner"] = partner;
    data["manager"] = manager;
    data["startDate"] = dateDebut;
    data["endDate"] = dateFinal;
    if (expenses != null) {
      data['expenses'] = expenses.toJson();
    }
    if (transportations != null) {
      data['transportation'] = transportations.toJson();
    }

    if (accomodations != null) {
      data['accomodation'] = accomodations.toJson();
    }
    if (visas != null) {
      data['visa'] = visas.toJson();
    }
    if (stepPartener != null) {
      data['stepPartener'] = stepPartener.toJson();
    }
    if (stepManager != null) {
      data['stepManager'] = stepManager.toJson();
    }
    if (vaccines != null) {
      data['vaccine'] = vaccines.toJson();
    }
    return data;
  }

  Missions();
}

class Expenses {
  String perdiem;
  double amount;
  String expensesComment;

  Expenses.fromJsonMap(Map<String, dynamic> map)
      : perdiem = map["perdiem"],
        amount = map["extraExpenses"],
        expensesComment = map["expensesComment"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["perdiem"] = perdiem;
    data["extraExpenses"] = amount;
    data["expensesComment"] = expensesComment;

    return data;
  }

  Expenses();
}

class Transportations {
  String transportationComment;

  bool needTransport;
  bool allerRetour;
  String departureCountryAller;
  String departureCityAller;
  String destinationCountryAller;
  String destinationCityAller;

  String missionCountry;
  String missionCity;

  Transportations.fromJsonMap(Map<String, dynamic> map)
      : transportationComment = map["transportationComment"],
        needTransport = map["needTransportation"],
        allerRetour = map["roundTrip"],
        departureCountryAller = map["onewayDepartureCountry"],
        departureCityAller = map["onewayDepartureCity"],
        destinationCountryAller = map["onewayDestinationCountry"],
        destinationCityAller = map["onewayDestinationCity"],
        missionCountry = map["missionCountry"],
        missionCity = map["MissionCity"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["transportationComment"] = transportationComment;

    data["needTransportation"] = needTransport;
    data["roundTrip"] = allerRetour;
    data["onewayDepartureCountry"] = departureCountryAller;
    data["onewayDepartureCity"] = departureCityAller;
    data["onewayDestinationCountry"] = destinationCountryAller;
    data["onewayDestinationCity"] = destinationCityAller;
    data["missionCountry"] = missionCountry;
    data["missionCity"] = missionCity;

    return data;
  }

  Transportations();
}

class Accomodations {
  String hotel;
  String rateHotelMax;
  double longitude;
  double altitude;
  bool needAccomodation;

  List<Map<dynamic, dynamic>> documents_visa = [];
  List<Map<dynamic, dynamic>> vaccin = [];

  Accomodations.fromJsonMap(Map<String, dynamic> map)
      : hotel = map["accomodationComment"],
        rateHotelMax = map["cityCap"],
        needAccomodation = map["needAccomodation"],
        longitude = map["longitude"],
        altitude = map["altitude"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["accomodationComment"] = hotel;
    data["cityCap"] = rateHotelMax;
    data["needAccomodation"] = needAccomodation;

    data["longitude"] = longitude;
    data["altitude"] = altitude;

    return data;
  }

  Accomodations();
}

class Visas {
  String validtePassport;
  String visa;
  bool obtenirVisa;

  List<Map<dynamic, dynamic>> documents_visa = [];

  Visas.fromJsonMap(Map<String, dynamic> map)
      : validtePassport = map["validtePassport"],
        visa = map["visa"],
        obtenirVisa = map["getVisa"],
        documents_visa = map["visaDocuments"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["validtePassport"] = validtePassport;
    data["visa"] = visa;
    data["getVisa"] = obtenirVisa;
    data["visaDocuments"] = documents_visa;

    return data;
  }

  Visas();
}

class Vaccines {
  List<Map<dynamic, dynamic>> vaccin = [];

  Vaccines.fromJsonMap(Map<String, dynamic> map) : vaccin = map["vaccines"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["vaccines"] = vaccin;

    return data;
  }

  Vaccines();
}

class StepPartener {
  String partner;
  String manager;
  String ManagerComment;
  String status;

  List<Map<dynamic, dynamic>> documents_visa = [];
  List<Map<dynamic, dynamic>> vaccin = [];

  StepPartener.fromJsonMap(Map<String, dynamic> map)
      : partner = map["partner"],
        manager = map["manager"],
        ManagerComment = map["ManagerComment"],
        status = map["status"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["partner"] = partner;
    data["manager"] = manager;
    data["ManagerComment"] = ManagerComment;
    data["status"] = status;

    return data;
  }

  StepPartener();
}

class StepManager {
  String partner;
  String manager;
  String facilite;
  String faciliteComment;
  String status;

  List<Map<dynamic, dynamic>> documents_visa = [];
  List<Map<dynamic, dynamic>> vaccin = [];

  StepManager.fromJsonMap(Map<String, dynamic> map)
      : partner = map["partner"],
        manager = map["manager"],
        facilite = map["facilite"],
        faciliteComment = map["faciliteComment"],
        status = map["status"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["partner"] = partner;
    data["manager"] = manager;
    data["facilite"] = facilite;

    data["faciliteComment"] = faciliteComment;
    data["status"] = status;

    return data;
  }

  StepManager();
}

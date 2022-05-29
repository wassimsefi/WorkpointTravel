import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:vato/SplashScreen.dart';

import 'package:vato/constants/light_colors.dart';
import 'package:jiffy/jiffy.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:progress_timeline/progress_timeline.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';
import 'package:vato/generated/intl/messages_en.dart';
import 'package:vato/models/Mission.dart';
import 'package:vato/models/Operation.dart';
import 'package:vato/models/Request.dart';
import 'package:vato/services/MissionService.dart';
import 'package:vato/services/OperationsService.dart';
import 'package:vato/services/RequestService.dart';
import 'package:vato/services/UserServices.dart';
import 'package:vato/travel/simple_map.dart';
import 'package:vato/widgets/mapScreen.dart';
import 'package:vato/widgets/navBar.dart';

import 'package:vato/widgets/top_container_travel.dart';

import 'package:fa_stepper/fa_stepper.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key key}) : super(key: key);

  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget>
    with TickerProviderStateMixin {
  int _currentStep = 0;
  String title;
  String hotelPreference = "";
  ScrollController _ScrollController;
  String email;
  String category;
  String type;
  String engagementManger;
  String engagementPartner;
  bool transport_required = true;
  bool round_trip = false;
  bool visaB = false;
  bool vaccineB = false;

  bool docVisa = false;

  List<bool> vaccinList = [];
  bool vaccinB = false;

  String country;
  String city;
  String code;
  String visa;
  String expensesComment;
  String transportationComment;

  String labeDateMission;
  String labeDatePasseport;

  dynamic object;
  dynamic formula;

  String amount;
  dynamic perdiem;
  final List<DropdownMenuItem> manager = [];

  dynamic pays_depart;
  dynamic city_depart;
  dynamic pays_destination;
  dynamic city_destination;

  dynamic departure_country;
  dynamic departure_city;
  dynamic destination_country;
  dynamic destination_city;

  dynamic pays_mission;
  dynamic city_mission;

  dynamic vaccin;
  dynamic hotel;
  Future<dynamic> getMissionObject;
  List<dynamic> missionObject;
  final List<DropdownMenuItem> objectMission = [];

  Future<dynamic> getMissionFormula;
  List<dynamic> missionFormula;
  final List<DropdownMenuItem> formulaMission = [];

  Future<dynamic> getHotel;
  List<dynamic> missionHotel;
  final List<DropdownMenuItem> hotelMission = [];

  Future<dynamic> getCountry;
  List<dynamic> missionCountry;
  final List<DropdownMenuItem> countryMission = [];

  Future<dynamic> getVaccine;
  List<dynamic> missionVaccine;
  final List<dynamic> vaccineMission = [];

  Future<dynamic> getIdCountry;
  dynamic missionIdCountry;

  Future<dynamic> getCite;
  List<dynamic> missionCite = [];
  final List<DropdownMenuItem> citeMission = [];

  Future<dynamic> getCiteMission;
  List<dynamic> listMissionCite = [];
  final List<DropdownMenuItem> listCiteMission = [];

  Future<dynamic> getCityCap;
  dynamic Mximum_rate_per_night;

  Future<dynamic> getCiteRetour;
  List<dynamic> missionCiteRetour = [];
  final List<DropdownMenuItem> citeMissionRetour = [];

  List<dynamic> missionCiteDes = [];
  String regionId = "";

  final List<DropdownMenuItem> citeDesMission = [];

  List<dynamic> missionCiteDesRetour = [];

  final List<DropdownMenuItem> citeDesMissionRetour = [];

  final List<DropdownMenuItem> citeListMission = [];

  List<dynamic> missionListCite = [];

  dynamic visaId;
  Future<dynamic> getVisa;
  String missionVisa = "";
  String idVisa = null;

  dynamic peridemObject;
  int peridemObjectstatus = 400;

  List<dynamic> listVaccin = [];

  List<dynamic> listDocVisa = [];
  List<dynamic> listNumDocVisa = [];

  final List<DropdownMenuItem> pays = [];

  String idHotel;
  double altitudeHotel = 36.806389;
  double longitudeHotel = 10.181667;

  int nbrDoc = 0;
  int nbrVaccin = 0;

  String _selectedAnimal;

  // This list holds all the suggestions

  final List<String> _listHotel = [];

  var VaccinList = <Map>[];
  var VisaList = <Map>[];

  String StartDate;
  String EndDate;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  int _selectedIndex = 0;

  String tokenLogin;
  String User_id;
  UserService _userService = new UserService();
  RequestService _requestservice = new RequestService();
  OperationService _operationservice = new OperationService();

  var User;
  List<dynamic> managers;
  List<dynamic> Users;
  Future<SharedPreferences> _prefs;
  Future<dynamic> getManagers;
  Future<dynamic> getUsers;
  dynamic selectedValueManger;
  dynamic selectedValuePartner;
  bool testTransport = false;
  bool testAccomdation = false;
  bool testVisa = false;

  final List<DropdownMenuItem> partner = [];

  void onStepContine() {
    final isLastStep = _currentStep == getSteps().length - 1;

    if (!_formKeys[_currentStep].currentState.validate()) {
      print('Please enter correct data');
    } else {
      _formKeys[_currentStep].currentState.save();

      if (isLastStep) {
        print("object ...............");
        //  loginUser();
        Missions missions = new Missions();
        Expenses expenses = new Expenses();
        Transportations transportation = new Transportations();
        Accomodations accomodations = new Accomodations();
        Vaccines vaccines = new Vaccines();
        Visas visas = new Visas();
        missions.title = title;
        missions.MissionFormula = formula["_id"];
        missions.MissionObjet = object["_id"];

        missions.manager = selectedValueManger["_id"];
        missions.partner = selectedValuePartner["_id"];
        missions.dateDebut = StartDate;
        missions.dateFinal = EndDate;
        if (peridemObject == null) {
          expenses.perdiem = null;
        } else {
          expenses.perdiem = peridemObject[0]["_id"];
        }
        expenses.amount = double.parse(amount);
        expenses.expensesComment = expensesComment;

        missions.expenses = expenses;

        transportation.transportationComment = transportationComment;

        transportation.needTransport = testTransport;
        transportation.allerRetour = round_trip;
        transportation.missionCountry = pays_mission["_id"];
        transportation.missionCity = city_mission["_id"];

        missions.transportations = transportation;
        print("testAccomdation" + testAccomdation.toString());
        print("testTransport" + testTransport.toString());
        print("round_trip" + testAccomdation.toString());

        if (testAccomdation == true) {
          accomodations.hotel = hotelPreference;
          accomodations.rateHotelMax = Mximum_rate_per_night["_id"];
          accomodations.altitude = altitudeHotel;
          accomodations.longitude = longitudeHotel;
          missions.accomodations = accomodations;
        }
        if (testTransport == true) {
          /*  missions.departureCountryAller = pays_depart["_id"];
          missions.departureCityAller = city_depart["_id"];
          missions.destinationCountryAller = pays_destination["_id"];
          missions.destinationCityAller = city_destination["_id"];*/

          transportation.departureCountryAller = departure_country["_id"];
          transportation.departureCityAller = departure_city["_id"];
          transportation.destinationCountryAller = destination_country["_id"];
          transportation.destinationCityAller = destination_city["_id"];
          missions.transportations = transportation;
        }
        visas.validtePassport = " 2058-28-02";
        visas.visa = idVisa;
        visas.obtenirVisa = visaB;

        for (var i = 0; i < nbrDoc; i++) {
          visas.documents_visa.add(VisaList[i]);
        }

        for (var i = 0; i < nbrVaccin; i++) {
          vaccines.vaccin.add(VaccinList[i]);
        }

        missions.visas = visas;
        missions.vaccines = vaccines;

        Requests request = new Requests();
        request.idSender = User_id;
        request.idReciever = selectedValueManger["_id"];
        print("********" + nbrDoc.toString());

        _missionService.addMission(missions, tokenLogin).then((value) async {
          print("okay !!!!");
          SweetAlert.show(context,
              subtitle: "Loading ...", style: SweetAlertStyle.loading);
          await Future.delayed(new Duration(seconds: 1), () async {
            if (value["status"].toString() == "200") {
              request.mission = value["data"]["_id"];
              request.name = "Mission";
              _requestservice
                  .addRequest(request, this.tokenLogin)
                  .then((value) async {
                //  missions.request = value["data"]["_id"];
                Operation operation = new Operation();
                operation.request = value["data"]["_id"];
                operation.OperationType = "TRAVEL";
                operation.status = "ACTIVE";
                operation.user = User_id;
                operation.date_debut = StartDate;
                operation.date_fin = EndDate;

                _operationservice
                    .addOperation(operation, this.tokenLogin)
                    .then((value) async {
                  if (value["status"].toString() == "200") {
                    if (value["status"].toString() == "200") {
                      await SweetAlert.show(context,
                          subtitle: " Done !", style: SweetAlertStyle.success,
                          onPress: (bool isConfirm) {
                        if (isConfirm) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => navigationScreen(
                                      0, null, null, 0, null, null, "home")));
                          return false;
                        }
                      });
                    }
                  }
                });
              });
            } else if (value["status"].toString() == "201") {
              await SweetAlert.show(context,
                  subtitle: value["message"], style: SweetAlertStyle.error);
            } else {
              await SweetAlert.show(context,
                  subtitle: "Ooops! Something Went Wrong!",
                  style: SweetAlertStyle.error);
            }
          });
        });

        return;
      }

      _currentStep += 1;
      _ScrollController = new ScrollController(
        initialScrollOffset: 0.0,
        keepScrollOffset: true,
      );
      setState(() {});

      if (_selectedIndex == 0) {
        round_trip = true;
      } else {
        round_trip = false;
      }

      if (_currentStep == 1) {
        setState(() {
          print("payyyyyyy :" + regionId.toString());
          print("aaaaa :" + formula["_id"]);
          print("pppppp :" + User["grade"]["_id"]);

          //Get PerDiem
          if (regionId != "" && formula != null && User != null) {
            _missionService
                .getPerdiem(regionId, formula["_id"], User["grade"]["_id"])
                .then((value) {
              setState(() {
                peridemObject = value["data"];

                print("***********peridemObject************" +
                    peridemObject.toString());
              });
            });
          }
        });
      }
    }
  }

  void onStepCancel() {
    if (_currentStep == 0) {
      return;
    }
    _currentStep -= 1;
    setState(() {});
  }

  MissionService _missionService = new MissionService();
  List<Step> getSteps() => [
        Step(
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 0,
            title: _currentStep == 0
                ? const Text("General Information",
                    style: TextStyle(fontSize: 14))
                : Text(""),
            content: _informationWidget()),
        Step(
          state: _currentStep <= 1 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 1,
          title: _currentStep == 1
              ? const Text(
                  "Details",
                  style: TextStyle(fontSize: 14),
                )
              : Text(""),
          content: _expensesWidget(),
        ),
        Step(
          state: _currentStep <= 2 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 2,
          title: _currentStep == 2
              ? const Text("Visa & vaccines", style: TextStyle(fontSize: 14))
              : Text(""),
          content: _visaVaccinetiWidget(),
        )
      ];

  @override
  void initState() {
    this.labeDateMission = "the full time of your mission";
    this.labeDatePasseport = "the full time of your passeport";

    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      setState(() {
        this.tokenLogin = prefs.get("token").toString();
        User_id = prefs.get("_id");
      });
      await _userService.getUserProfil(User_id, tokenLogin).then((userData) {
        setState(() {
          User = userData["data"];
        });
      });
      getManagers = _userService.getMangers(tokenLogin).then((value) {
        setState(() {
          managers = value["data"];
        });

        managers.asMap().forEach((index, element) {
          if (User["_id"].toString() != element["_id"].toString()) {
            setState(() {
              manager.add(
                DropdownMenuItem(
                    child:
                        Text(element["firstname"] + " " + element["lastname"]),
                    value: element),
              );
            });
          }
          /*  manager.forEach((element) {
            if (element.value["_id"] == User["manager"]["_id"]) {
              selectedValue = element.value;
            }
          });*/
          //  selectedValue = User["manager"];
        });
      });

      getUsers = _userService.getUsers(tokenLogin).then((value) {
        setState(() {
          Users = value["data"];
        });

        Users.asMap().forEach((index, element) {
          if (User["_id"].toString() != element["_id"].toString()) {
            setState(() {
              partner.add(
                DropdownMenuItem(
                    child:
                        Text(element["firstname"] + " " + element["lastname"]),
                    value: element),
              );
            });
          }
          /*    manager.forEach((element) {
            if (element.value["_id"] == User["manager"]["_id"]) {
              selectedValue = element.value;
            }
          });*/
          //  selectedValue = User["manager"];
        });
      });
    });

    getMissionObject = _missionService.getAllMissionObject().then((value) {
      setState(() {
        missionObject = value["data"];
      });

      missionObject.asMap().forEach((index, element) {
        setState(() {
          objectMission.add(
            DropdownMenuItem(child: Text(element["name"]), value: element),
          );
        });
      });
    });

    getMissionFormula = _missionService.getAllMissionFormula().then((value) {
      setState(() {
        missionFormula = value["data"];
      });

      missionFormula.asMap().forEach((index, element) {
        setState(() {
          formulaMission.add(
            DropdownMenuItem(child: Text(element["name"]), value: element),
          );
        });

        //  selectedValue = User["manager"];
      });
    });

    getHotel = _missionService.getAllHotel().then((value) {
      setState(() {
        _listHotel.clear();
        missionHotel = value["data"];
        print("hotel list :" + value["data"][0]["name"].toString());
        for (var i = 0; i < value["data"].length; i++) {
          _listHotel.add(value["data"][i]["name"]);
          print("list hotel longitude : " +
              value["data"][i]["longitude"]["\$numberDecimal"].toString());
          print("list hotel altitude : " +
              value["data"][i]["altitude"]["\$numberDecimal"].toString());
        }
      });
    });

    getCountry = _missionService.getAllCountry().then((value) {
      setState(() {
        missionCountry = value["data"];
      });

      missionCountry.asMap().forEach((index, element) {
        setState(() {
          countryMission.add(
            DropdownMenuItem(child: Text(element["name"]), value: element),
          );
        });
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: NeumorphicColors.background,
        colorScheme: ColorScheme.light(
          primary: LightColors.kDarkBlue,
        ),
      ),
      child: Stepper(
        type: StepperType.horizontal,
        steps: getSteps(),
        currentStep: _currentStep,
        onStepContinue: onStepContine,
        onStepCancel: onStepCancel,
        controlsBuilder: (context, {onStepContinue, onStepCancel}) {
          return Row(
            children: [
              if (_currentStep != 0)
                Expanded(
                    child: TextButton(
                        onPressed: onStepCancel, child: Text('Back'))),
              SizedBox(
                width: 12,
              ),
              if (_currentStep == getSteps().length - 1)
                Expanded(
                    child: ElevatedButton(
                        onPressed: onStepContinue, child: Text('Submit'))),
              if (_currentStep != getSteps().length - 1)
                Expanded(
                    child: ElevatedButton(
                        onPressed: onStepContinue, child: Text('NEXT'))),
            ],
          );
        },
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget _informationWidget() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return LightColors.kDarkBlue;
      }
      return Colors.red;
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKeys[0],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  height: 105,
                  // color: Colors.grey[200],
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      //     shape: NeumorphicShape.flat,
                      color: NeumorphicColors.background,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Title :",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: title,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) =>
                                val.isEmpty ? 'Entrez titel' : null,
                            onChanged: (val) => title = val,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              // labelText: '  Title  ',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        /*  Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text("eeeee",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      )*/
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  height: 105,
                  // color: Colors.grey[200],
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      //     shape: NeumorphicShape.flat,
                      color: NeumorphicColors.background,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Country :",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SearchChoices.single(
                            items: countryMission,
                            value: pays_mission,
                            hint: "Country",
                            searchHint: "Select your mission country ",
                            onChanged: (value) {
                              setState(() async {
                                pays_mission = value;

                                getIdCountry = _missionService
                                    .getCountryNyName(value["name"])
                                    .then((value) {
                                  missionIdCountry = value["data"];

//Get Visa
                                  visaId = missionIdCountry[0]["visa"];

                                  listVaccin = missionIdCountry[0]["vaccine"];

                                  listDocVisa.clear();
                                  listNumDocVisa.clear();

                                  if (visaId == null) {
                                    nbrDoc = 0;
                                  } else {
                                    getVisa = _missionService
                                        .getVisaById(visaId)
                                        .then((value) {
                                      idVisa = value["data"]["_id"];

                                      missionVisa = value["data"]["name"];
                                      for (var i = 0;
                                          i < User["visa"].length;
                                          i++) {
                                        if (missionVisa ==
                                            User["visa"][i]["id"]["name"]) {
                                          setState(() {
                                            testVisa = true;
                                          });
                                        }
                                      }

                                      nbrDoc = value["data"]["documents_list"]
                                          .length;
                                      for (var i = 0;
                                          i <
                                              value["data"]["documents_list"]
                                                  .length;
                                          i++) {
                                        var map = {};
                                        map['document'] = value["data"]["_id"];

                                        map['name'] = value["data"]
                                            ["documents_list"][i]["document"];
                                        map['nbrDoc'] = value["data"]
                                                ["documents_list"][i]
                                            ["number_of_document"];
                                        map['isChecked'] = false;
                                        VisaList.add(map);

                                        _missionService
                                            .getDocVisaById(value["data"]
                                                    ["documents_list"][i]
                                                ["document"])
                                            .then((value) {
                                          listDocVisa
                                              .add(value["data"]["name"]);
                                          map['name'] = value["data"]["name"];
                                          map['document'] =
                                              value["data"]["_id"];
                                        });

                                        listNumDocVisa.add(value["data"]
                                                ["documents_list"][i]
                                            ["number_of_document"]);
                                      }
                                    });
                                  }

// Get List Vaccin
                                  nbrVaccin =
                                      value["data"][0]["vaccine"].length;
                                  vaccineMission.clear();
                                  for (var i = 0; i < listVaccin.length; i++) {
                                    _missionService
                                        .getVaccine(listVaccin[i])
                                        .then((value) {
                                      vaccineMission.add(value["data"]["name"]);

                                      var map = {};
                                      print("........." +
                                          value["data"].toString());
                                      map['idVaccine'] = value["data"]["_id"];

                                      map['name'] = value["data"]["name"];
                                      map['isChecked'] = false;
                                      map['vaccine'] = false;

                                      for (var i = 0;
                                          i < User["vaccine"].length;
                                          i++) {
                                        if (value["data"]["name"] ==
                                            User["vaccine"][i]["id"]["name"]) {
                                          map['vaccine'] = true;
                                        }
                                      }
                                      VaccinList.add(map);
                                    });
                                  }

//Get Cite
                                  _missionService
                                      .getCiteByCountry(
                                          missionIdCountry[0]["_id"])
                                      .then((value) {
                                    for (var i = 0;
                                        i < missionListCite.length;
                                        i++) {
                                      citeListMission.removeLast();
                                    }
                                    setState(() {
                                      missionListCite = value["data"];
                                    });

                                    int i = 0;

                                    missionListCite
                                        .asMap()
                                        .forEach((index, element) {
                                      i++;
                                      citeListMission.add(
                                        DropdownMenuItem(
                                            child: Text("" + element["name"]),
                                            value: element),
                                      );
                                    });
                                  });

//Get Region

                                  _missionService
                                      .getCountry(missionIdCountry[0]["_id"])
                                      .then((value) {
                                    setState(() {
                                      regionId = value["data"]["region"];
                                      // print("***********region************" + value["data"]["region"].toString());
                                    });
                                  });

//Get CityCap

                                  getCityCap = _missionService
                                      .getCityCapByCountry(
                                          missionIdCountry[0]["_id"])
                                      .then((value) {
                                    Mximum_rate_per_night = value["data"];
                                    //  print("................... 111" +value["data"]["Mximum_rate_per_night"].toString());
                                  });
                                });

                                //  print("Country !!!!  2 : " + missionIdCountry);
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  height: 105,
                  // color: Colors.grey[200],
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      //     shape: NeumorphicShape.flat,
                      color: NeumorphicColors.background,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "City :",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SearchChoices.single(
                            items: citeListMission,
                            value: city_mission,
                            hint: "City",
                            searchHint: "Select your mission city ",
                            onChanged: (value) {
                              setState(() {
                                city_mission = value;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  height: 105,
                  // color: Colors.grey[200],
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      //     shape: NeumorphicShape.flat,
                      color: NeumorphicColors.background,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Object :",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SearchChoices.single(
                            items: objectMission,
                            value: object,
                            hint: "Object",
                            searchHint: "Select your mission object ",
                            onChanged: (value) {
                              setState(() {
                                object = value;
                                print("-----------" + object.toString());
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  height: 105,
                  // color: Colors.grey[200],
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      //     shape: NeumorphicShape.flat,
                      color: NeumorphicColors.background,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Formula :",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SearchChoices.single(
                            items: formulaMission,
                            value: formula,
                            hint: "Formula",
                            searchHint: "Select your Mission formula",
                            onChanged: (value) {
                              setState(() {
                                formula = value;
                                print("-----------" +
                                    value["needTransportation"].toString() +
                                    value["needAccomdation"].toString());
                                testTransport = value["needTransportation"];
                                testAccomdation = value["needAccomdation"];
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  height: 105,
                  // color: Colors.grey[200],
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      //     shape: NeumorphicShape.flat,
                      color: NeumorphicColors.background,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Engagement manager :",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SearchChoices.single(
                            items: manager,
                            value: selectedValueManger,
                            hint: "Engagement manager",
                            searchHint: "Select your engagement manager",
                            onChanged: (value) {
                              setState(() {
                                selectedValueManger = value;
                                print("-----------" +
                                    selectedValueManger.toString());
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  height: 105,
                  // color: Colors.grey[200],
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      //     shape: NeumorphicShape.flat,
                      color: NeumorphicColors.background,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Engagement Partner :",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SearchChoices.single(
                            items: partner,
                            value: selectedValuePartner,
                            hint: "Engagement Partner",
                            searchHint: "Select your engagement partner",
                            onChanged: (value) {
                              setState(() {
                                selectedValuePartner = value;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height ,
                child: Theme(
              data: Theme.of(context).copyWith(
                  accentColor: LightColors.kDarkBlue,
                  primaryColor: LightColors.kDarkBlue,
                  buttonTheme: ButtonThemeData(
                    highlightColor: LightColors.kDarkBlue,
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          secondary: LightColors.kDarkBlue,
                          primary: LightColors.kDarkBlue,
                          primaryVariant: LightColors.kDarkBlue,
                        ),
                  )),
              child: Builder(
                  builder: (context) => TextButton.icon(
                        label: Text(
                          this.labeDateMission,
                          style: TextStyle(color: Colors.black54),
                        ),
                        icon: Icon(
                          Icons.date_range,
                          color: Colors.black54,
                        ),
                        onPressed: () async {
                          final List<DateTime> picked =
                              await DateRangePicker.showDatePicker(
                                  context: context,
                                  initialFirstDate: new DateTime.now(),
                                  initialLastDate: (new DateTime.now())
                                      .add(new Duration(days: 7)),
                                  firstDate: new DateTime(2015),
                                  lastDate:
                                      new DateTime(DateTime.now().year + 2));
                          if (picked != null && picked.length == 2) {
                            print(picked.toList());
                            StartDate =
                                DateFormat('yyyy-MM-dd').format(picked[0]);
                            EndDate =
                                DateFormat('yyyy-MM-dd').format(picked[1]);

                            setState(() {
                              this.labeDateMission =
                                  "From " + this.StartDate + "  To " + EndDate;
                            });
                          }
                        },
                      )),
            )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _expensesWidget() {
    return SingleChildScrollView(
      controller: _ScrollController,
      child: Form(
        key: _formKeys[1],
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(0),
                height: 400,
                child: Neumorphic(
                    style: NeumorphicStyle(
                      depth: 1,

                      //shape: NeumorphicShape.convex,
                      color: NeumorphicColors.background,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.all(Radius.elliptical(20, 20))),
                    ),
                    child: Column(
                        //    mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.paid_outlined,
                                  color: LightColors.kDarkBlue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Expenses ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Container(
                                height: 50,
                                // color: Colors.grey[200],
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    //     shape: NeumorphicShape.flat,
                                    color: NeumorphicColors.background,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.info_outlined,
                                              color: LightColors.kDarkBlue,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "Applicable perdiem :",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.8, left: 12, right: 10),
                                        child: peridemObject == null
                                            ? Text("No Perdiem")
                                            : Row(
                                                children: [
                                                  Text("" +
                                                      peridemObject[0]
                                                              ["indemnity"]
                                                          .toString()),
                                                  Icon(
                                                    Icons.euro,
                                                    color:
                                                        LightColors.kDarkBlue,
                                                  ),
                                                ],
                                              ),
                                        //  child: Text("Your Perdiem : "),
                                      ),
                                      /*  Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text("eeeee",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      )*/
                                    ],
                                  ),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Container(
                                height: 82,
                                // color: Colors.grey[200],
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    //     shape: NeumorphicShape.flat,
                                    color: NeumorphicColors.background,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Requested additionel amount :",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  initialValue: amount,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  onChanged: (val) =>
                                                      amount = val,
                                                  decoration: InputDecoration(
                                                    // labelText: '  Amount ',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.euro,
                                            color: LightColors.kDarkBlue,
                                          ),
                                        ],
                                      ),
                                      /*  Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text("eeeee",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      )*/
                                    ],
                                  ),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Container(
                                height: 170,
                                // color: Colors.grey[200],
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    //     shape: NeumorphicShape.flat,
                                    color: NeumorphicColors.background,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Comment :",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          initialValue: expensesComment,
                                          minLines: 2,
                                          maxLines: 5,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            //  labelText: 'Comment expense',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          onChanged: (val) =>
                                              expensesComment = val,
                                        ),
                                      ),

                                      /*  Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text("eeeee",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      )*/
                                    ],
                                  ),
                                ),
                              )),
                        ]))),
            SizedBox(height: 20),
            testTransport == true
                ? Container(
                    padding: EdgeInsets.all(0),
                    height: 900,
                    child: Neumorphic(
                        style: NeumorphicStyle(
                          depth: 1,

                          //shape: NeumorphicShape.convex,
                          color: NeumorphicColors.background,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.all(Radius.elliptical(20, 20))),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.flight_takeoff_outlined,
                                      color: LightColors.kDarkBlue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Transportation ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Container(
                                    height: 85,
                                    // color: Colors.grey[200],
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        //     shape: NeumorphicShape.flat,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(8)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SearchChoices.single(
                                          items: countryMission,
                                          value: pays_depart,
                                          hint:
                                              "Transportation departure country",
                                          searchHint:
                                              "Select your transportation departure country ",
                                          onChanged: (value) {
                                            //   setState(() async {
                                            pays_depart = value;

                                            departure_country = pays_depart;
                                            getIdCountry = _missionService
                                                .getCountryNyName(value["name"])
                                                .then((value) {
                                              missionIdCountry = value["data"];
                                              //  print("Cite length : " + missionCite.length.toString());
                                              // print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + missionIdCountry.toString());
                                              getCite = _missionService
                                                  .getCiteByCountry(
                                                      missionIdCountry[0]
                                                          ["_id"])
                                                  .then((value) {
                                                for (var i = 0;
                                                    i < missionCite.length;
                                                    i++) {
                                                  citeMission.removeLast();
                                                }
                                                setState(() {
                                                  missionCite = value["data"];
                                                  print("dataaaaaaaa :" +
                                                      missionCite.length
                                                          .toString());
                                                });

                                                int i = 0;
                                                print("dataaaaaaaa 222 :" +
                                                    citeMission.length
                                                        .toString());
                                                missionCite
                                                    .asMap()
                                                    .forEach((index, element) {
                                                  i++;
                                                  citeMission.add(
                                                    DropdownMenuItem(
                                                        child: Text("" +
                                                            element["name"]),
                                                        value: element),
                                                  );
                                                });

                                                print("dataaaaaaaa 333 :" +
                                                    citeMission.length
                                                        .toString());
                                              });
                                            });

                                            //  print("Country !!!!  2 : " + missionIdCountry);
                                            //  });
                                          },
                                          isExpanded: true,
                                        ),
                                      ),
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Container(
                                    height: 85,
                                    // color: Colors.grey[200],
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        //     shape: NeumorphicShape.flat,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(8)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SearchChoices.single(
                                          items: citeMission,
                                          value: city_depart,
                                          hint: "Transportation departure city",
                                          searchHint:
                                              "Select your transportation departure city ",
                                          onChanged: (value) {
                                            setState(() {
                                              print("numbre : " +
                                                  citeMission.length
                                                      .toString());
                                              city_depart = value;
                                              departure_city = city_depart;
                                            });
                                          },
                                          isExpanded: true,
                                        ),
                                      ),
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Container(
                                    height: 85,
                                    // color: Colors.grey[200],
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        //     shape: NeumorphicShape.flat,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(8)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SearchChoices.single(
                                          items: countryMission,
                                          value: pays_destination,
                                          hint: "Destination country",
                                          searchHint:
                                              "Select your Destination country ",
                                          onChanged: (value) {
                                            setState(() async {
                                              pays_destination = value;
                                              destination_country =
                                                  pays_destination;
                                              getIdCountry = _missionService
                                                  .getCountryNyName(
                                                      value["name"])
                                                  .then((value) {
                                                missionIdCountry =
                                                    value["data"];

                                                //Get Cite
                                                _missionService
                                                    .getCiteByCountry(
                                                        missionIdCountry[0]
                                                            ["_id"])
                                                    .then((value) {
                                                  for (var i = 0;
                                                      i < missionCiteDes.length;
                                                      i++) {
                                                    citeDesMission.removeLast();
                                                  }
                                                  setState(() {
                                                    missionCiteDes =
                                                        value["data"];
                                                  });

                                                  int i = 0;

                                                  missionCiteDes
                                                      .asMap()
                                                      .forEach(
                                                          (index, element) {
                                                    i++;
                                                    citeDesMission.add(
                                                      DropdownMenuItem(
                                                          child: Text("" +
                                                              element["name"]),
                                                          value: element),
                                                    );
                                                  });
                                                });
                                              });

                                              //  print("Country !!!!  2 : " + missionIdCountry);
                                            });
                                          },
                                          isExpanded: true,
                                        ),
                                      ),
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Container(
                                    height: 85,
                                    // color: Colors.grey[200],
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        //     shape: NeumorphicShape.flat,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(8)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SearchChoices.single(
                                          items: citeDesMission,
                                          value: city_destination,
                                          hint: "Destination city",
                                          searchHint: "Select your perdiem ",
                                          onChanged: (value) {
                                            setState(() {
                                              city_destination = value;
                                              destination_city =
                                                  city_destination;
                                            });
                                          },
                                          isExpanded: true,
                                        ),
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      //height: 60,
                                      width: MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).size.width /
                                              2.5,

                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: NeumorphicToggle(
                                              height: 50,
                                              selectedIndex: _selectedIndex,
                                              displayForegroundOnlyIfSelected:
                                                  true,
                                              alphaAnimationCurve:
                                                  Curves.easeInCirc,
                                              children: [
                                                ToggleElement(
                                                  background: Center(
                                                      child: Text(
                                                    "Round trip",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                                  foreground: Center(
                                                      child: Text(
                                                    "Round trip",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  )),
                                                ),
                                                ToggleElement(
                                                  background: Center(
                                                      child: Text(
                                                    "One way",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                                  foreground: Center(
                                                      child: Text(
                                                    "One way",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  )),
                                                )
                                              ],
                                              thumb: Neumorphic(
                                                style: NeumorphicStyle(
                                                  boxShape: NeumorphicBoxShape
                                                      .roundRect(
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedIndex = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Container(
                                    height: 85,
                                    // color: Colors.grey[200],
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        //     shape: NeumorphicShape.flat,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(8)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Transportation :",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                          child: departure_city ==
                                                                  null
                                                              ? Text(
                                                                  "Select depart",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54),
                                                                )
                                                              : Text("" +
                                                                  departure_country[
                                                                          "name"]
                                                                      .toString() +
                                                                  " ( " +
                                                                  departure_city[
                                                                          "name"]
                                                                      .toString() +
                                                                  " )")),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.compare_arrows,
                                                          color: Colors.black54,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (city_depart ==
                                                                departure_city) {
                                                              destination_country =
                                                                  pays_depart;
                                                              destination_city =
                                                                  city_depart;

                                                              departure_country =
                                                                  pays_destination;
                                                              departure_city =
                                                                  city_destination;
                                                            } else {
                                                              destination_country =
                                                                  pays_destination;
                                                              destination_city =
                                                                  city_destination;

                                                              departure_country =
                                                                  pays_depart;
                                                              departure_city =
                                                                  city_depart;
                                                            }
                                                          });
                                                        },
                                                      ),
                                                      Flexible(
                                                          child: destination_city ==
                                                                  null
                                                              ? Text(
                                                                  "Select destination",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54),
                                                                )
                                                              : Text("" +
                                                                  destination_country[
                                                                          "name"]
                                                                      .toString() +
                                                                  " ( " +
                                                                  destination_city[
                                                                          "name"]
                                                                      .toString() +
                                                                  " )")),
                                                    ],
                                                  ))),
                                        ],
                                      ),
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Container(
                                    height: 170,
                                    // color: Colors.grey[200],
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        //     shape: NeumorphicShape.flat,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(8)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Comment :",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              initialValue:
                                                  transportationComment,
                                              minLines: 2,
                                              maxLines: 5,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                //  labelText: 'Comment expense',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              onChanged: (val) =>
                                                  transportationComment = val,
                                            ),
                                          ),

                                          /*  Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10),
                                      child: Text("eeeee",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    )*/
                                        ],
                                      ),
                                    ),
                                  )),
                            ])))
                : Container(),
            SizedBox(height: 20),
            testAccomdation == true
                ? Container(
                    padding: EdgeInsets.all(0),
                    height: 800,
                    child: Neumorphic(
                        style: NeumorphicStyle(
                          depth: 1,

                          //shape: NeumorphicShape.convex,
                          color: NeumorphicColors.background,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.all(Radius.elliptical(20, 20))),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.hotel_outlined,
                                      color: LightColors.kDarkBlue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Accomodation ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Container(
                                    height: 50,
                                    // color: Colors.grey[200],
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        //     shape: NeumorphicShape.flat,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(8)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.info_outlined,
                                                  color: LightColors.kDarkBlue,
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  "Max rate/night :",
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0.8, left: 12, right: 10),
                                            child: peridemObject == null
                                                ? Text("No Perdiem")
                                                : Text("" +
                                                    Mximum_rate_per_night[
                                                            "Mximum_rate_per_night"]
                                                        .toString()),
                                            //  child: Text("Your Perdiem : "),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Container(
                                    height: 170,
                                    // color: Colors.grey[200],
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        //     shape: NeumorphicShape.flat,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(8)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Comment :",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              initialValue: hotelPreference,
                                              minLines: 2,
                                              maxLines: 5,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                //  labelText: 'Comment expense',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              onChanged: (val) =>
                                                  hotelPreference = val,
                                            ),
                                          ),

                                          /*  Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10),
                                      child: Text("eeeee",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    )*/
                                        ],
                                      ),
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Container(
                                    height: 500,
                                    // color: Colors.grey[200],
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        //     shape: NeumorphicShape.flat,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(8)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              "You can pick your preferred location for hotel booking :",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 12),
                                            child: MapScreen(
                                                altitudeHotel: "36.258",
                                                longitudeHotel: "9.589"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ])))
                : Container(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _visaVaccinetiWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeys[2],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(0),
                height: 400,
                child: Neumorphic(
                    style: NeumorphicStyle(
                      depth: 1,

                      //shape: NeumorphicShape.convex,
                      color: NeumorphicColors.background,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.all(Radius.elliptical(20, 20))),
                    ),
                    child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: Image.asset(
                                  "assets/images/visa.png",
                                  width: 30,
                                  height: 30,
                                )),
                                Text(
                                  "Visa ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Container(
                                height: 50,
                                // color: Colors.grey[200],
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    //     shape: NeumorphicShape.flat,
                                    color: NeumorphicColors.background,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.info_outline,
                                              color: LightColors.kDarkBlue,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "Your passport validity :",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.8, left: 12, right: 10),
                                          child: User != null
                                              ? Text(
                                                  Jiffy(User[
                                                          "passportValidity"])
                                                      .yMMMMd
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black))
                                              : Text("null"),
                                          //  child: Text("Your Perdiem : "),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Container(
                                height: 100,
                                // color: Colors.grey[200],
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    //     shape: NeumorphicShape.flat,
                                    color: NeumorphicColors.background,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.info_outline,
                                              color: LightColors.kDarkBlue,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "Applicable visa for mission country :",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.8, left: 12, right: 10),
                                          child: nbrDoc == 0
                                              ? Text("Null")
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 10, 0),
                                                  child: Container(
                                                    height: 50,
                                                    // color: Colors.grey[200],
                                                    child: Center(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10,
                                                              left: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              missionVisa
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                          testVisa == true
                                                              ? Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .clear_outlined,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                        ],
                                                      ),
                                                    )),
                                                  ))

                                          //  child: Text("Your Perdiem : "),
                                          ),
                                    ],
                                  ),
                                ),
                              )),
                          Expanded(
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  //  hoverColor: LightColors.kDarkBlue,
                                  //  fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: visaB,
                                  onChanged: (bool value) {
                                    setState(() {
                                      visaB = value;
                                    });
                                  },
                                ),
                                Flexible(
                                  child: AutoSizeText(
                                    "I want to get this visa requested documents. ",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          ),
                          visaB == true
                              ? nbrDoc == 0
                                  ? Center(child: Text("aucun visa"))
                                  : Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: nbrDoc,
                                            itemBuilder: (context, i) {
                                              return Card(
                                                color:
                                                    NeumorphicColors.background,
                                                child: ListTile(
                                                  subtitle: Text(
                                                      "number of document : " +
                                                          VisaList[i]["nbrDoc"]
                                                              .toString()),
                                                  title: Text(
                                                      "" + VisaList[i]["name"]),
                                                  leading:
                                                      Icon(Icons.file_copy),
                                                  trailing: Checkbox(
                                                    //  hoverColor: LightColors.kDarkBlue,
                                                    //  fillColor: MaterialStateProperty.resolveWith(getColor),
                                                    value: VisaList[i]
                                                        ["isChecked"],
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        VisaList[i]
                                                                ["isChecked"] =
                                                            newValue;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    )
                              : new Container(),
                        ]))),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.all(0),
                height: 500,
                child: Neumorphic(
                    style: NeumorphicStyle(
                      depth: 1,

                      //shape: NeumorphicShape.convex,
                      color: NeumorphicColors.background,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.all(Radius.elliptical(20, 20))),
                    ),
                    child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: SvgPicture.asset(
                                  "assets/images/vaccin.svg",
                                  width: 30,
                                  height: 30,
                                )),
                                Text(
                                  "Vaccines ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          vaccineMission.length == 0
                              ? Center(child: Text("aucun vaccines"))
                              : Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          child: Container(
                                            height: 200,
                                            // color: Colors.grey[200],
                                            child: Neumorphic(
                                              style: NeumorphicStyle(
                                                //     shape: NeumorphicShape.flat,
                                                color:
                                                    NeumorphicColors.background,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.info_outline,
                                                          color: LightColors
                                                              .kDarkBlue,
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          "Applicable visa for mission country :",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      child: ListView.builder(
                                                        //physics:NeverScrollableScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: nbrVaccin,
                                                        itemBuilder:
                                                            (context, i) {
                                                          return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      0),
                                                              child: Container(
                                                                height: 50,
                                                                // color: Colors.grey[200],
                                                                child: Center(
                                                                    child:
                                                                        Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 10,
                                                                      left: 10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          VaccinList[i]["name"]
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black)),
                                                                      VaccinList[i]["vaccine"] ==
                                                                              true
                                                                          ? Icon(
                                                                              Icons.check,
                                                                              color: Colors.green,
                                                                            )
                                                                          : Icon(
                                                                              Icons.clear_outlined,
                                                                              color: Colors.red,
                                                                            ),
                                                                    ],
                                                                  ),
                                                                )),
                                                              ));
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                      Expanded(
                                        child: Row(
                                          //   mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              //  hoverColor: LightColors.kDarkBlue,
                                              //  fillColor: MaterialStateProperty.resolveWith(getColor),
                                              value: vaccineB,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  vaccineB = value;
                                                });
                                              },
                                            ),
                                            Flexible(
                                              child: AutoSizeText(
                                                "I want to get this vaccine requested documents. ",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      vaccineB == true
                                          ? Expanded(
                                              child: SizedBox(
                                                child: ListView.builder(
                                                  //physics:NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount: nbrVaccin,
                                                  itemBuilder: (context, i) {
                                                    return Card(
                                                        color: NeumorphicColors
                                                            .background,
                                                        child: ListTile(
                                                          title: Text("" +
                                                              VaccinList[i]
                                                                  ["name"]),
                                                          leading: Icon(
                                                              Icons.medication),
                                                          trailing: Checkbox(
                                                            //  hoverColor: LightColors.kDarkBlue,
                                                            //  fillColor: MaterialStateProperty.resolveWith(getColor),
                                                            value: VaccinList[i]
                                                                ["isChecked"],
                                                            onChanged:
                                                                (newValue) {
                                                              setState(() {
                                                                VaccinList[i][
                                                                        "isChecked"] =
                                                                    newValue;
                                                                print("test test test ::: " +
                                                                    VaccinList
                                                                        .toString());
                                                              });
                                                            },
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              ),
                                            )
                                          : new Container(),
                                    ],
                                  ),
                                )
                        ]))),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
          child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}

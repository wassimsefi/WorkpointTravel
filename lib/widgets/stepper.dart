import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:vato/SplashScreen.dart';

import 'package:vato/constants/light_colors.dart';

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

  String email;
  String category;
  String type;
  String engagementManger;
  String engagementPartner;
  bool transport_required = true;
  bool round_trip = false;
  bool visaB = false;
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

  dynamic pays_depart_retour;
  dynamic city_depart_retour;
  dynamic pays_destination_retour;
  dynamic city_destination_retour;

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
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  TabController _tabController;

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
        missions.title = title;
        missions.MissionFormula = formula["_id"];
        missions.MissionObjet = object["_id"];

        missions.manager = selectedValueManger["_id"];
        missions.partner = selectedValuePartner["_id"];
        missions.dateDebut = StartDate;
        missions.dateFinal = EndDate;
        if (peridemObject == null) {
          missions.perdiem = null;
        } else {
          missions.perdiem = peridemObject[0]["_id"];
        }
        missions.amount = amount;
        missions.expensesComment = expensesComment;
        missions.transportationComment = transportationComment;

        missions.needTransport = testTransport;
        missions.allerRetour = round_trip;

        print("testAccomdation" + testAccomdation.toString());
        print("testTransport" + testTransport.toString());
        print("round_trip" + testAccomdation.toString());

        if (testAccomdation == true) {
          missions.hotel = hotelPreference;
          missions.rateHotelMax = Mximum_rate_per_night["_id"];
          missions.altitude = altitudeHotel;
          missions.longitude = longitudeHotel;
        }
        if (testTransport == true) {
          missions.departureCountryAller = pays_depart["_id"];
          missions.departureCityAller = city_depart["_id"];
          missions.destinationCountryAller = pays_destination["_id"];
          missions.destinationCityAller = city_destination["_id"];

          if (round_trip == true) {
            missions.departureCountryRetour = pays_destination["_id"];
            missions.departureCityRetour = city_depart["_id"];
            missions.destinationCountryRetour = pays_destination_retour["_id"];
            missions.destinationCityRetour = city_destination_retour["_id"];
          }
        }
        missions.validtePassport = " 2058-28-02";
        missions.visa = idVisa;
        missions.obtenirVisa = visaB;
        print("***********" + nbrDoc.toString());
        /* for (var i = 0; i < nbrDoc; i++) {
          print("***" + VisaList[i].toString());
          missions.documents_visa[i] = VisaList[i];
        }*/

        for (var i = 0; i < nbrDoc; i++) {
          missions.documents_visa.add(VisaList[i]);
        }

        for (var i = 0; i < nbrVaccin; i++) {
          missions.vaccin.add(VaccinList[i]);
        }

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
      setState(() {});

      print("***********_currentStep************" + _currentStep.toString());
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
      if (_currentStep == 3) {
        print("tatattata : " + tabController.index.toString());

        if (tabController.index == 0) {
          round_trip = false;
        } else {
          round_trip = true;
        }
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
                ? const Text("Informations", style: TextStyle(fontSize: 14))
                : Text(""),
            content: _informationWidget()),
        Step(
          state: _currentStep <= 1 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 1,
          title: _currentStep == 1
              ? const Text(
                  "Expenses",
                  style: TextStyle(fontSize: 14),
                )
              : Text(""),
          content: _expensesWidget(),
        ),
        Step(
          state: _currentStep <= 2 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 2,
          title: _currentStep == 2
              ? const Text("Transport", style: TextStyle(fontSize: 14))
              : Text(""),
          content: testTransport == true
              ? _TransportWidget()
              : _TransportWidgetNul(),
        ),
        Step(
          state: _currentStep <= 3 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 3,
          title: _currentStep == 3
              ? const Text("Accomodation", style: TextStyle(fontSize: 14))
              : Text(""),
          content: testAccomdation == true
              ? _AccomodationWidget()
              : _AccomodationWidgetNul(),
        ),
        Step(
          state: _currentStep <= 4 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 4,
          title: _currentStep == 4
              ? const Text("Visa and vaccines", style: TextStyle(fontSize: 14))
              : Text(""),
          content: _visaVaccinetiWidget(),
        )
      ];

  TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

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
    _tabController = new TabController(length: 2, vsync: this);
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
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: title,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => val.isEmpty ? 'Entrez titel' : null,
                onChanged: (val) => title = val,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: '  Title mission ',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: countryMission,
                value: pays_destination,
                hint: "Destination country",
                searchHint: "Select your Destination country ",
                onChanged: (value) {
                  setState(() async {
                    pays_destination = value;

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
                        getVisa =
                            _missionService.getVisaById(visaId).then((value) {
                          idVisa = value["data"]["_id"];

                          missionVisa = value["data"]["name"];

                          nbrDoc = value["data"]["documents_list"].length;
                          for (var i = 0;
                              i < value["data"]["documents_list"].length;
                              i++) {
                            var map = {};
                            map['document'] = value["data"]["_id"];

                            map['name'] =
                                value["data"]["documents_list"][i]["document"];
                            map['nbrDoc'] = value["data"]["documents_list"][i]
                                ["number_of_document"];
                            map['isChecked'] = false;
                            VisaList.add(map);

                            _missionService
                                .getDocVisaById(value["data"]["documents_list"]
                                    [i]["document"])
                                .then((value) {
                              listDocVisa.add(value["data"]["name"]);
                              map['name'] = value["data"]["name"];
                              map['document'] = value["data"]["_id"];
                            });

                            listNumDocVisa.add(value["data"]["documents_list"]
                                [i]["number_of_document"]);
                          }
                        });
                      }

// Get List Vaccin
                      nbrVaccin = value["data"][0]["vaccine"].length;
                      vaccineMission.clear();
                      for (var i = 0; i < listVaccin.length; i++) {
                        _missionService.getVaccine(listVaccin[i]).then((value) {
                          vaccineMission.add(value["data"]["name"]);

                          var map = {};
                          print("........." + value["data"].toString());
                          map['idVaccine'] = value["data"]["_id"];

                          map['name'] = value["data"]["name"];
                          map['isChecked'] = false;
                          VaccinList.add(map);
                        });
                      }

//Get Cite
                      _missionService
                          .getCiteByCountry(missionIdCountry[0]["_id"])
                          .then((value) {
                        for (var i = 0; i < missionCiteDes.length; i++) {
                          citeDesMission.removeLast();
                        }
                        setState(() {
                          missionCiteDes = value["data"];
                        });

                        int i = 0;

                        missionCiteDes.asMap().forEach((index, element) {
                          i++;
                          citeDesMission.add(
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
                          .getCityCapByCountry(missionIdCountry[0]["_id"])
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: citeDesMission,
                value: city_destination,
                hint: "Destination city",
                searchHint: "Select your perdiem ",
                onChanged: (value) {
                  setState(() {
                    city_destination = value;
                  });
                },
                isExpanded: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: objectMission,
                value: object,
                hint: "Mission object",
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: formulaMission,
                value: formula,
                hint: "Mission formula",
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: manager,
                value: selectedValueManger,
                hint: "Manager",
                searchHint: "Select your Manager",
                onChanged: (value) {
                  setState(() {
                    selectedValueManger = value;
                    print("-----------" + selectedValueManger.toString());
                  });
                },
                isExpanded: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: partner,
                value: selectedValuePartner,
                hint: "Partner",
                searchHint: "Select your partner",
                onChanged: (value) {
                  setState(() {
                    selectedValuePartner = value;
                  });
                },
                isExpanded: true,
              ),
            ),
            Column(
              children: [
                Text("Date de mission :"),
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
                                      lastDate: new DateTime(
                                          DateTime.now().year + 2));
                              if (picked != null && picked.length == 2) {
                                print(picked.toList());
                                StartDate =
                                    DateFormat('yyyy-MM-dd').format(picked[0]);
                                EndDate =
                                    DateFormat('yyyy-MM-dd').format(picked[1]);

                                setState(() {
                                  this.labeDateMission = "From " +
                                      this.StartDate +
                                      "  To " +
                                      EndDate;
                                });
                              }
                            },
                          )),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _expensesWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeys[1],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                height: 350,
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
                            child: Text(
                              "Expenses ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
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
                                        child: Text(
                                          "Applicable perdiem :",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.8, left: 12, right: 10),
                                        child: peridemObject == null
                                            ? Text("No Perdiem")
                                            : Text("" +
                                                peridemObject[0]["indemnity"]
                                                    .toString()),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Applicable perdiem :",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          initialValue: amount,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (val) => amount = val,
                                          decoration: InputDecoration(
                                            labelText: '  Amount ',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
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
                        ]))),
            Padding(
              padding: const EdgeInsets.only(top: 0.8, left: 12),
              child: peridemObject == null
                  ? Text("Your Perdiem : No Perdiem")
                  : Text("Your Perdiem : " +
                      peridemObject[0]["name"].toString() +
                      " ..." +
                      peridemObject[0]["indemnity"].toString()),
              //  child: Text("Your Perdiem : "),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: amount,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (val) => amount = val,
                decoration: InputDecoration(
                  labelText: '  Amount ',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: expensesComment,
                minLines: 2,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Comment expense',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (val) => expensesComment = val,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _TransportWidget() {
    DateTime selectedDate = DateTime.now();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        });
    }

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

    return Form(
      key: _formKeys[2],
      child: Container(
        height: (MediaQuery.of(context).size.height) - 390,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //   SizedBox(height: 50),

            Container(
              // height: 50,
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: LightColors.kDarkBlue,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TabBar(
                      //   physics: NeverScrollableScrollPhysics(),
                      unselectedLabelColor: Colors.white,
                      labelColor: Colors.black,
                      indicatorColor: Colors.white,
                      indicatorWeight: 2,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      controller: tabController,
                      tabs: [
                        Tab(
                          text: 'One way',
                        ),
                        Tab(
                          text: 'Round trip',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  _TansportWidget1(),
                  _TansportWidget2(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _TransportWidgetNul() {
    DateTime selectedDate = DateTime.now();

    return SingleChildScrollView(
      child: Form(
          key: _formKeys[2],
          child: Container(
            height: MediaQuery.of(context).size.height - 400,
            child: Center(
              child: Text("No Transport"),
            ),
          )),
    );
  }

  Widget _AccomodationWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeys[3],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /* Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: hotelMission,
                value: hotel,
                hint: "Hotel",
                searchHint: "Select your Hotel ",
                onChanged: (value) {
                  setState(() {
                    hotel = value;
                  });
                },
                isExpanded: true,
              ),
            ),*/

            /*     Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Select Preference Hotel :"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue value) {
                  // When the field is empty
                  if (value.text.isEmpty) {
                    return [];
                  }

                  // The logic to find out which ones should appear
                  return _listHotel.where((suggestion) => suggestion
                      .toLowerCase()
                      .contains(value.text.toLowerCase()));
                },
                onSelected: (value) {
                  setState(() {
                    hotelPreference = value;

                    /*    _missionService
                        .getHotelbyName(hotelPreference)
                        .then((value) {
                      idHotel = value["data"];
                      print("hotel id :" + idHotel.toString());
                    });

                    _missionService.getHotelbyid(idHotel).then((value) {
                      altitudeHotel =
                          value["data"]["altitude"]["\$numberDecimal"];
                      longitudeHotel =
                          value["data"]["longitude"]["\$numberDecimal"];
                      print("altitude Hotel :" + altitudeHotel.toString());
                    });
               */
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("" + hotelPreference)),
            ),
       */

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: hotelPreference,
                //  autovalidateMode: AutovalidateMode.onUserInteraction,
// validator: (val) => val.isEmpty ? 'Entrez titel' : null,
                onChanged: (val) => hotelPreference = val,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: '  Preference Hotel ',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 12),
              child: Text("Mximum rate per night : " +
                  Mximum_rate_per_night["Mximum_rate_per_night"].toString()),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 12),
              child: Text("select your preferred hotel :"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 12),
              child:
                  MapScreen(altitudeHotel: "36.258", longitudeHotel: "9.589"),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _AccomodationWidgetNul() {
    DateTime selectedDate = DateTime.now();

    return SingleChildScrollView(
      child: Form(
          key: _formKeys[3],
          child: Container(
            height: MediaQuery.of(context).size.height - 400,
            child: Center(
              child: Text("No Accomodation"),
            ),
          )),
    );
  }

  Widget _visaVaccinetiWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeys[4],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /*     SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                             // The checkboxes will be here
                      Column(
                          children: availableHobbies.map((hobby) {
                        return CheckboxListTile(
                            value: hobby["isChecked"],
                            title: Text(hobby["name"]),
                            onChanged: (newValue) {
                              setState(() {
                                hobby["isChecked"] = newValue;
                              });
                            });
                      }).toList()),

                      // Display the result here
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      Wrap(
                        children: availableHobbies.map((hobby) {
                          if (hobby["isChecked"] == true) {
                            return Card(
                              elevation: 3,
                              color: Colors.amber,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(hobby["name"]),
                              ),
                            );
                          }

                          return Container();
                        }).toList(),
                      )

                      
                    ]),
              ),
            ), */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Validité du passeport : 24/08/2026"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                nbrDoc == 0
                    ? Text("Visa : null ")
                    : Text("Visa : " + missionVisa),
              ],
            ),
            Row(
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
                Text("Je dois obtenir le visa "),
              ],
            ),
            visaB == true
                ? nbrDoc == 0
                    ? Center(child: Text("aucun visa"))
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: nbrDoc,
                        itemBuilder: (context, i) {
                          return Card(
                            color: NeumorphicColors.background,
                            child: ListTile(
                              subtitle: Text("number of document : " +
                                  VisaList[i]["nbrDoc"].toString()),
                              title: Text("" + VisaList[i]["name"]),
                              leading: Icon(Icons.file_copy),
                              trailing: Checkbox(
                                //  hoverColor: LightColors.kDarkBlue,
                                //  fillColor: MaterialStateProperty.resolveWith(getColor),
                                value: VisaList[i]["isChecked"],
                                onChanged: (newValue) {
                                  setState(() {
                                    VisaList[i]["isChecked"] = newValue;
                                  });
                                },
                              ),
                            ),
                          );
                        })
                : new Container(),
            SizedBox(
              height: 20,
            ),
            Row(
              //    mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("List vaccin :"),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            vaccineMission.length == 0
                ? Center(child: Text("aucun vaccin"))
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: nbrVaccin,
                    itemBuilder: (context, i) {
                      return Card(
                          color: NeumorphicColors.background,
                          child: ListTile(
                            title: Text("" + VaccinList[i]["name"]),
                            leading: Icon(Icons.medication),
                            trailing: Checkbox(
                              //  hoverColor: LightColors.kDarkBlue,
                              //  fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: VaccinList[i]["isChecked"],
                              onChanged: (newValue) {
                                setState(() {
                                  VaccinList[i]["isChecked"] = newValue;
                                  print("test test test ::: " +
                                      VaccinList.toString());
                                });
                              },
                            ),
                          ));
                    },
                  )
          ],
        ),
      ),
    );

    /* return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 360, left: 20.0, right: 20.0),
        children: <Widget>[
          SizedBox(height: 15.0),
          TabBar(
              controller: _tabController,
              indicatorColor: Color(0xff13f4ef),
              indicatorWeight: 6,
              // indicator: BoxDecoration(
              //     color: Color(0xff13f4ef),
              //     borderRadius: BorderRadius.all(
              //         Radius.circular(40.0))),
              labelColor: Color(0xff001a33),
              // isScrollable: true,
              labelPadding: EdgeInsets.only(right: 40.0, left: 40.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text('All',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Receive',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
              ]),
          Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: [
                Column(
                  children: [
                    Text("wassiomm"),
                    Text("wassiomm"),
                    Text("wassiomm"),
                    Text("wassiomm"),
                    Text("wassiomm"),
                    Text("wassiomm"),
                    Text("wassiomm"),
                    Text("wassiomm"),
                    Text("wassiomm"),
                    Text("wassiomm"),
                    Text("wassiomm"),
                    Text("wassiomm"),
                    Text("wassiomm"),
                  ],
                ),
                Text("taraiiiii"),
              ]))
        ],
      ),
    );
*/
  }

/*Widget _TransportWidget() {
    DateTime selectedDate = DateTime.now();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        });
    }

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
        key: _formKeys[2],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Need Transport"),
                    Checkbox(
                      //  hoverColor: LightColors.kDarkBlue,
                      //  fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: transport_required,
                      onChanged: (bool value) {
                        setState(() {
                          transport_required = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Aller-Retour"),
                    Checkbox(
                      //  hoverColor: LightColors.kDarkBlue,
                      //  fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: round_trip,
                      onChanged: (bool value) {
                        setState(() {
                          round_trip = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Text("Aller : "),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: countryMission,
                value: pays_depart,
                hint: "Departure country",
                searchHint: "Select your departure country ",
                onChanged: (value) {
                  //   setState(() async {
                  pays_depart = value;

                  getIdCountry = _missionService
                      .getCountryNyName(value["name"])
                      .then((value) {
                    missionIdCountry = value["data"];
                    //  print("Cite length : " + missionCite.length.toString());
                    // print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + missionIdCountry.toString());
                    getCite = _missionService
                        .getCiteByCountry(missionIdCountry[0]["_id"])
                        .then((value) {
                      for (var i = 0; i < missionCite.length; i++) {
                        citeMission.removeLast();
                      }
                      setState(() {
                        missionCite = value["data"];
                        print("dataaaaaaaa :" + missionCite.length.toString());
                      });

                      int i = 0;
                      print(
                          "dataaaaaaaa 222 :" + citeMission.length.toString());
                      missionCite.asMap().forEach((index, element) {
                        i++;
                        citeMission.add(
                          DropdownMenuItem(
                              child: Text("" + element["name"]),
                              value: element),
                        );
                      });

                      print(
                          "dataaaaaaaa 333 :" + citeMission.length.toString());
                    });
                  });

                  //  print("Country !!!!  2 : " + missionIdCountry);
                  //  });
                },
                isExpanded: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: citeMission,
                value: city_depart,
                hint: "Departure city",
                searchHint: "Select your Departure city ",
                onChanged: (value) {
                  setState(() {
                    print("numbre : " + citeMission.length.toString());
                    city_depart = value;
                  });
                },
                isExpanded: true,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Pays de destination :",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(pays_destination["name"].toString(),
                              style: TextStyle(color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: citeDesMission,
                value: city_destination,
                hint: "Destination city",
                searchHint: "Select your perdiem ",
                onChanged: (value) {
                  setState(() {
                    city_destination = value;
                  });
                },
                isExpanded: true,
              ),
            ),
            round_trip == true ? new Text("Retour : ") : new Container(),
            round_trip == true
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchChoices.single(
                      items: countryMission,
                      value: pays_depart_retour,
                      hint: "Departure country",
                      searchHint: "Select your departure country ",
                      onChanged: (value) {
                        setState(() async {
                          pays_depart_retour = value;

                          getIdCountry = _missionService
                              .getCountryNyName(value["name"])
                              .then((value) {
                            missionIdCountry = value["data"];
                            //  print("Cite length : " + missionCite.length.toString());
                            // print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + missionIdCountry.toString());
                            getCiteRetour = _missionService
                                .getCiteByCountry(missionIdCountry[0]["_id"])
                                .then((value) {
                              for (var i = 0;
                                  i < missionCiteRetour.length;
                                  i++) {
                                citeMissionRetour.removeLast();
                              }
                              setState(() {
                                missionCiteRetour = value["data"];
                                print("dataaaaaaaa :" +
                                    missionCiteRetour.length.toString());
                              });

                              int i = 0;
                              print("dataaaaaaaa 222 :" +
                                  citeMissionRetour.length.toString());
                              missionCiteRetour
                                  .asMap()
                                  .forEach((index, element) {
                                i++;
                                citeMissionRetour.add(
                                  DropdownMenuItem(
                                      child: Text("$i : " + element["name"]),
                                      value: element),
                                );
                              });

                              print("dataaaaaaaa 333 :" +
                                  citeMissionRetour.length.toString());
                            });
                          });

                          //  print("Country !!!!  2 : " + missionIdCountry);
                        });
                      },
                      isExpanded: true,
                    ),
                  )
                : new Container(),
            round_trip == true
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchChoices.single(
                      items: citeMissionRetour,
                      value: city_depart_retour,
                      hint: "Departure city",
                      searchHint: "Select your Departure city ",
                      onChanged: (value) {
                        setState(() {
                          print("numbre : " +
                              citeMissionRetour.length.toString());
                          city_depart_retour = value;
                        });
                      },
                      isExpanded: true,
                    ),
                  )
                : new Container(),
            round_trip == true
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchChoices.single(
                      items: countryMission,
                      value: pays_destination_retour,
                      hint: "Destination country",
                      searchHint: "Select your Destination country ",
                      onChanged: (value) {
                        setState(() {
                          pays_destination_retour = value;

                          getIdCountry = _missionService
                              .getCountryNyName(value["name"])
                              .then((value) {
                            missionIdCountry = value["data"];

                            /*   visaId = missionIdCountry[0]["visa"];
                            //  print("..................." + visaId.toString());
                            //  print("Cite length : " + missionCite.length.toString());

                            getVisa = _missionService
                                .getVisaById(visaId)
                                .then((value) {
                              setState(() async {
                                missionVisa = value["data"]["name"];
                                // print("..................." + value["data"]["name"]);
                              });
                            });*/

                            getCite = _missionService
                                .getCiteByCountry(missionIdCountry[0]["_id"])
                                .then((value) {
                              for (var i = 0;
                                  i < missionCiteDesRetour.length;
                                  i++) {
                                citeDesMissionRetour.removeLast();
                              }
                              setState(() {
                                missionCiteDesRetour = value["data"];
                                print("dataaaaaaaa :" +
                                    missionCiteDesRetour.length.toString());
                              });

                              int i = 0;

                              missionCiteDesRetour
                                  .asMap()
                                  .forEach((index, element) {
                                i++;
                                citeDesMissionRetour.add(
                                  DropdownMenuItem(
                                      child: Text("$i : " + element["name"]),
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
                  )
                : new Container(),
            round_trip == true
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchChoices.single(
                      items: citeDesMissionRetour,
                      value: city_destination_retour,
                      hint: "Destination city",
                      searchHint: "Select your perdiem ",
                      onChanged: (value) {
                        setState(() {
                          city_destination_retour = value;
                        });
                      },
                      isExpanded: true,
                    ),
                  )
                : new Container(),
          ],
        ),
      ),
    );
  }

*/

  Widget _TansportWidget1() {
    /*  @override
    void initState() {
     
     
      print("ccc");
    }*/

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: transportationComment,
              minLines: 2,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Comment transportation',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (val) => transportationComment = val,
            ),
          ),
          SizedBox(height: 10),
          Text("Aller : "),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: countryMission,
              value: pays_depart,
              hint: "Departure country",
              searchHint: "Select your departure country ",
              onChanged: (value) {
                //   setState(() async {
                pays_depart = value;

                getIdCountry = _missionService
                    .getCountryNyName(value["name"])
                    .then((value) {
                  missionIdCountry = value["data"];
                  //  print("Cite length : " + missionCite.length.toString());
                  // print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + missionIdCountry.toString());
                  getCite = _missionService
                      .getCiteByCountry(missionIdCountry[0]["_id"])
                      .then((value) {
                    for (var i = 0; i < missionCite.length; i++) {
                      citeMission.removeLast();
                    }
                    setState(() {
                      missionCite = value["data"];
                      print("dataaaaaaaa :" + missionCite.length.toString());
                    });

                    int i = 0;
                    print("dataaaaaaaa 222 :" + citeMission.length.toString());
                    missionCite.asMap().forEach((index, element) {
                      i++;
                      citeMission.add(
                        DropdownMenuItem(
                            child: Text("" + element["name"]), value: element),
                      );
                    });

                    print("dataaaaaaaa 333 :" + citeMission.length.toString());
                  });
                });

                //  print("Country !!!!  2 : " + missionIdCountry);
                //  });
              },
              isExpanded: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: citeMission,
              value: city_depart,
              hint: "Departure city",
              searchHint: "Select your Departure city ",
              onChanged: (value) {
                setState(() {
                  print("numbre : " + citeMission.length.toString());
                  city_depart = value;
                });
              },
              isExpanded: true,
            ),
          ),
          /*  Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: countryMission,
              value: pays_destination,
              hint: "Destination country",
              searchHint: "Select your Destination country ",
              onChanged: (value) {
                setState(() async {
                  pays_destination = value;

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
                      getVisa =
                          _missionService.getVisaById(visaId).then((value) {
                        idVisa = value["data"]["_id"];

                        missionVisa = value["data"]["name"];

                        nbrDoc = value["data"]["documents_list"].length;
                        for (var i = 0;
                            i < value["data"]["documents_list"].length;
                            i++) {
                          var map = {};
                          map['document'] = value["data"]["_id"];

                          map['name'] =
                              value["data"]["documents_list"][i]["document"];
                          map['nbrDoc'] = value["data"]["documents_list"][i]
                              ["number_of_document"];
                          map['isChecked'] = false;
                          VisaList.add(map);

                          _missionService
                              .getDocVisaById(value["data"]["documents_list"][i]
                                  ["document"])
                              .then((value) {
                            listDocVisa.add(value["data"]["name"]);
                            map['name'] = value["data"]["name"];
                            map['document'] = value["data"]["_id"];
                          });

                          listNumDocVisa.add(value["data"]["documents_list"][i]
                              ["number_of_document"]);
                        }
                      });
                    }

// Get List Vaccin
                    nbrVaccin = value["data"][0]["vaccine"].length;
                    vaccineMission.clear();
                    for (var i = 0; i < listVaccin.length; i++) {
                      _missionService.getVaccine(listVaccin[i]).then((value) {
                        vaccineMission.add(value["data"]["name"]);

                        var map = {};
                        print("........." + value["data"].toString());
                        map['idVaccin'] = value["data"]["_id"];

                        map['name'] = value["data"]["name"];
                        map['isChecked'] = false;
                        VaccinList.add(map);
                      });
                    }

//Get Cite
                    _missionService
                        .getCiteByCountry(missionIdCountry[0]["_id"])
                        .then((value) {
                      for (var i = 0; i < missionCiteDes.length; i++) {
                        citeDesMission.removeLast();
                      }
                      setState(() {
                        missionCiteDes = value["data"];
                      });

                      int i = 0;

                      missionCiteDes.asMap().forEach((index, element) {
                        i++;
                        citeDesMission.add(
                          DropdownMenuItem(
                              child: Text("" + element["name"]),
                              value: element),
                        );
                      });
                    });

//Get CityCap

                    getCityCap = _missionService
                        .getCityCapByCountry(missionIdCountry[0]["_id"])
                        .then((value) {
                      Mximum_rate_per_night =
                          value["data"]["Mximum_rate_per_night"];
                      //  print("................... 111" +value["data"]["Mximum_rate_per_night"].toString());
                    });
                  });

                  //  print("Country !!!!  2 : " + missionIdCountry);
                });
              },
              isExpanded: true,
            ),
          ),
         */
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                height: 50,
                // color: Colors.grey[200],
                child: Neumorphic(
                  style: NeumorphicStyle(
                    //     shape: NeumorphicShape.flat,
                    color: NeumorphicColors.background,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Pays de departure :",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                            pays_destination == null
                                ? "Null"
                                : pays_destination["name"].toString(),
                            style: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: citeDesMission,
              value: city_destination,
              hint: "Destination city",
              searchHint: "Select your perdiem ",
              onChanged: (value) {
                setState(() {
                  city_destination = value;
                });
              },
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _TansportWidget2() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: transportationComment,
              minLines: 2,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Comment transportation',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (val) => transportationComment = val,
            ),
          ),
          SizedBox(height: 10),
          Text("Aller : "),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: countryMission,
              value: pays_depart,
              hint: "Departure country",
              searchHint: "Select your departure country ",
              onChanged: (value) {
                //   setState(() async {
                pays_depart = value;

                getIdCountry = _missionService
                    .getCountryNyName(value["name"])
                    .then((value) {
                  missionIdCountry = value["data"];
                  //  print("Cite length : " + missionCite.length.toString());
                  // print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + missionIdCountry.toString());
                  getCite = _missionService
                      .getCiteByCountry(missionIdCountry[0]["_id"])
                      .then((value) {
                    for (var i = 0; i < missionCite.length; i++) {
                      citeMission.removeLast();
                    }
                    setState(() {
                      missionCite = value["data"];
                      print("dataaaaaaaa :" + missionCite.length.toString());
                    });

                    int i = 0;
                    print("dataaaaaaaa 222 :" + citeMission.length.toString());
                    missionCite.asMap().forEach((index, element) {
                      i++;
                      citeMission.add(
                        DropdownMenuItem(
                            child: Text("" + element["name"]), value: element),
                      );
                    });

                    print("dataaaaaaaa 333 :" + citeMission.length.toString());
                  });
                });

                //  print("Country !!!!  2 : " + missionIdCountry);
                //  });
              },
              isExpanded: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: citeMission,
              value: city_depart,
              hint: "Departure city",
              searchHint: "Select your Departure city ",
              onChanged: (value) {
                setState(() {
                  print("numbre : " + citeMission.length.toString());
                  city_depart = value;
                });
              },
              isExpanded: true,
            ),
          ),

          /*   Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: countryMission,
              value: pays_destination,
              hint: "Destination country",
              searchHint: "Select your Destination country ",
              onChanged: (value) {
                setState(() async {
                  pays_destination = value;

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
                      getVisa =
                          _missionService.getVisaById(visaId).then((value) {
                        idVisa = value["data"]["_id"];

                        missionVisa = value["data"]["name"];

                        nbrDoc = value["data"]["documents_list"].length;
                        for (var i = 0;
                            i < value["data"]["documents_list"].length;
                            i++) {
                          var map = {};
                          map['document'] = value["data"]["_id"];

                          map['name'] =
                              value["data"]["documents_list"][i]["document"];
                          map['nbrDoc'] = value["data"]["documents_list"][i]
                              ["number_of_document"];
                          map['isChecked'] = false;
                          VisaList.add(map);

                          _missionService
                              .getDocVisaById(value["data"]["documents_list"][i]
                                  ["document"])
                              .then((value) {
                            listDocVisa.add(value["data"]["name"]);
                            map['name'] = value["data"]["name"];
                            map['document'] = value["data"]["_id"];
                          });

                          listNumDocVisa.add(value["data"]["documents_list"][i]
                              ["number_of_document"]);
                        }
                      });
                    }

// Get List Vaccin
                    nbrVaccin = value["data"][0]["vaccine"].length;
                    vaccineMission.clear();
                    for (var i = 0; i < listVaccin.length; i++) {
                      _missionService.getVaccine(listVaccin[i]).then((value) {
                        vaccineMission.add(value["data"]["name"]);

                        var map = {};
                        print("........." + value["data"].toString());
                        map['idVaccin'] = value["data"]["_id"];

                        map['name'] = value["data"]["name"];
                        map['isChecked'] = false;
                        VaccinList.add(map);
                      });
                    }

//Get Cite
                    _missionService
                        .getCiteByCountry(missionIdCountry[0]["_id"])
                        .then((value) {
                      for (var i = 0; i < missionCiteDes.length; i++) {
                        citeDesMission.removeLast();
                      }
                      setState(() {
                        missionCiteDes = value["data"];
                      });

                      int i = 0;

                      missionCiteDes.asMap().forEach((index, element) {
                        i++;
                        citeDesMission.add(
                          DropdownMenuItem(
                              child: Text("" + element["name"]),
                              value: element),
                        );
                      });
                    });

//Get CityCap

                    getCityCap = _missionService
                        .getCityCapByCountry(missionIdCountry[0]["_id"])
                        .then((value) {
                      Mximum_rate_per_night =
                          value["data"]["Mximum_rate_per_night"];
                      //  print("................... 111" +value["data"]["Mximum_rate_per_night"].toString());
                    });
                  });

                  //  print("Country !!!!  2 : " + missionIdCountry);
                });
              },
              isExpanded: true,
            ),
          ),
      */
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                height: 50,
                // color: Colors.grey[200],
                child: Neumorphic(
                  style: NeumorphicStyle(
                    //     shape: NeumorphicShape.flat,
                    color: NeumorphicColors.background,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Pays de departure :",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                            pays_destination == null
                                ? "Null"
                                : pays_destination["name"].toString(),
                            style: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: citeDesMission,
              value: city_destination,
              hint: "Destination city",
              searchHint: "Select your perdiem ",
              onChanged: (value) {
                setState(() {
                  city_destination = value;
                });
              },
              isExpanded: true,
            ),
          ),
          new Text("Retour : "),
          /*  Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: countryMission,
              value: pays_depart_retour,
              hint: "Departure country",
              searchHint: "Select your departure country ",
              onChanged: (value) {
                setState(() async {
                  pays_depart_retour = value;

                  getIdCountry = _missionService
                      .getCountryNyName(value["name"])
                      .then((value) {
                    missionIdCountry = value["data"];
                    //  print("Cite length : " + missionCite.length.toString());
                    // print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + missionIdCountry.toString());
                    getCiteRetour = _missionService
                        .getCiteByCountry(missionIdCountry[0]["_id"])
                        .then((value) {
                      for (var i = 0; i < missionCiteRetour.length; i++) {
                        citeMissionRetour.removeLast();
                      }
                      setState(() {
                        missionCiteRetour = value["data"];
                        print("dataaaaaaaa :" +
                            missionCiteRetour.length.toString());
                      });

                      int i = 0;
                      print("dataaaaaaaa 222 :" +
                          citeMissionRetour.length.toString());
                      missionCiteRetour.asMap().forEach((index, element) {
                        i++;
                        citeMissionRetour.add(
                          DropdownMenuItem(
                              child: Text("$i : " + element["name"]),
                              value: element),
                        );
                      });

                      print("dataaaaaaaa 333 :" +
                          citeMissionRetour.length.toString());
                    });
                  });

                  //  print("Country !!!!  2 : " + missionIdCountry);
                });
              },
              isExpanded: true,
            ),
          ),
        */
          /* 
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: citeMissionRetour,
              value: city_depart_retour,
              hint: "Departure city",
              searchHint: "Select your Departure city ",
              onChanged: (value) {
                setState(() {
                  print("numbre : " + citeMissionRetour.length.toString());
                  city_depart_retour = value;
                });
              },
              isExpanded: true,
            ),
          ),
       */
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                height: 50,
                // color: Colors.grey[200],
                child: Neumorphic(
                  style: NeumorphicStyle(
                    //     shape: NeumorphicShape.flat,
                    color: NeumorphicColors.background,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Pays de departure :",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                            pays_destination == null
                                ? "Null"
                                : pays_destination["name"].toString(),
                            style: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                height: 50,
                // color: Colors.grey[200],
                child: Neumorphic(
                  style: NeumorphicStyle(
                    //     shape: NeumorphicShape.flat,
                    color: NeumorphicColors.background,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "city de departure :",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                            city_destination == null
                                ? "Null"
                                : city_destination["name"].toString(),
                            style: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: countryMission,
              value: pays_destination_retour,
              hint: "Destination country",
              searchHint: "Select your Destination country ",
              onChanged: (value) {
                setState(() {
                  pays_destination_retour = value;

                  getIdCountry = _missionService
                      .getCountryNyName(value["name"])
                      .then((value) {
                    missionIdCountry = value["data"];

                    /*   visaId = missionIdCountry[0]["visa"];
                              //  print("..................." + visaId.toString());
                              //  print("Cite length : " + missionCite.length.toString());
    
                              getVisa = _missionService
                                  .getVisaById(visaId)
                                  .then((value) {
                                setState(() async {
                                  missionVisa = value["data"]["name"];
                                  // print("..................." + value["data"]["name"]);
                                });
                              });*/

                    getCite = _missionService
                        .getCiteByCountry(missionIdCountry[0]["_id"])
                        .then((value) {
                      for (var i = 0; i < missionCiteDesRetour.length; i++) {
                        citeDesMissionRetour.removeLast();
                      }
                      setState(() {
                        missionCiteDesRetour = value["data"];
                        print("dataaaaaaaa :" +
                            missionCiteDesRetour.length.toString());
                      });

                      int i = 0;

                      missionCiteDesRetour.asMap().forEach((index, element) {
                        i++;
                        citeDesMissionRetour.add(
                          DropdownMenuItem(
                              child: Text("$i : " + element["name"]),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchChoices.single(
              items: citeDesMissionRetour,
              value: city_destination_retour,
              hint: "Destination city",
              searchHint: "Select your perdiem ",
              onChanged: (value) {
                setState(() {
                  city_destination_retour = value;
                });
              },
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
          child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}

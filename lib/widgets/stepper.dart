import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:search_choices/search_choices.dart';
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
import 'package:vato/services/MissionService.dart';
import 'package:vato/travel/simple_map.dart';
import 'package:vato/widgets/mapScreen.dart';

import 'package:vato/widgets/top_container_travel.dart';

import 'package:fa_stepper/fa_stepper.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key key}) : super(key: key);

  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _currentStep = 0;
  String title;
  String hotelPreference;

  String email;
  String category;
  String type;
  String engagementManger;
  String engagementPartner;
  bool transport_required = true;
  bool round_trip = false;
  bool visaB = true;
  //List<bool> vaccinB;
  bool vaccinB = false;

  String country;
  String city;
  String code;
  String visa;
  String comment;
  String labeDateMission;
  String labeDatePasseport;

  dynamic object;
  dynamic formula;

  dynamic amount;
  dynamic perdiem;
  dynamic manager;
  dynamic partner;

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
  dynamic Mximum_rate_per_night = 0;

  Future<dynamic> getCiteRetour;
  List<dynamic> missionCiteRetour = [];
  final List<DropdownMenuItem> citeMissionRetour = [];

  List<dynamic> missionCiteDes = [];

  final List<DropdownMenuItem> citeDesMission = [];

  List<dynamic> missionCiteDesRetour = [];

  final List<DropdownMenuItem> citeDesMissionRetour = [];

  dynamic visaId;
  Future<dynamic> getVisa;
  String missionVisa = "";

  final List<DropdownMenuItem> pays = [];

  String StartDate;
  String EndDate;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  void onStepContine() {
    final isLastStep = _currentStep == getSteps().length - 1;

    if (!_formKeys[_currentStep].currentState.validate()) {
      print('Please enter correct data');
    } else {
      _formKeys[_currentStep].currentState.save();

      if (isLastStep) {
        print("object ...............");
        //  loginUser();
        return;
      }
      _currentStep += 1;
      setState(() {});
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

  @override
  void initState() {
    this.labeDateMission = "the full time of your mission";
    this.labeDatePasseport = "the full time of your passeport";

    setState(() {
      pays.add(
        DropdownMenuItem(child: Text("Tunis"), value: "Tunis"),
      );
      pays.add(
        DropdownMenuItem(child: Text("Italia"), value: "Italia"),
      );
      pays.add(
        DropdownMenuItem(child: Text("Qatar"), value: "Qatar"),
      );
      pays.add(
        DropdownMenuItem(child: Text("Libya"), value: "Libya"),
      );
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

        //  selectedValue = User["manager"];
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
        missionHotel = value["data"];
      });

      missionHotel.asMap().forEach((index, element) {
        setState(() {
          hotelMission.add(
            DropdownMenuItem(child: Text(element["name"]), value: element),
          );
        });

        //  selectedValue = User["manager"];
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

        //  selectedValue = User["manager"];
      });
    });
/*
    getVaccine = _missionService.getVaccine().then((value) {
      setState(() {
        missionVaccine = value["data"];
      });

      missionVaccine.asMap().forEach((index, element) {
        setState(() {
          vaccineMission.add(element["name"]);
        });

        for (var i = 0; i < vaccineMission.length; i++) {
          vaccinB[i] = false;
        }

        print("List Vacinne : " + vaccineMission.toString());
        print("List etat Vacinne : " + vaccinB.toString());

        //  selectedValue = User["manager"];
      });
    });
*/
    // TODO: implement initState
    super.initState();
  }
  /*void loginUser() async {
    const String apiUrl = "http://192.168.1.17:3000/demande/create";
    DemandeElement demande = DemandeElement(
      formule: formula!,
      needTransport: isChecked,
      title: title!,
      type: type!,
      category: category!,
      city: city!,
      comment: comment!,
      country: country!,
      date: DateTime.now(),
      email: email!,
      engagementManager: engagementManger!,
      engagementPartner: engagementPartner!,
    );
    final Response = await http.post(apiUrl, body: demande.toJson());
    print("helsdfsdflo");
    if (Response.statusCode == 200) {
      final String responseString = Response.body;
      print("helllo it works ");
      // return userModelFromJson(responseString);
    } else if (Response.statusCode == 401) {
      throw Exception(showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Log In Error'),
          content: Text(
            'Account is not activated! ou not found! ',
            style: TextStyle(fontSize: 20.0, color: Colors.red),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text('OK'))
          ],
        ),
      ));
    }
  }*/

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
          content: _TransportWidget(),
        ),
        Step(
          state: _currentStep <= 3 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 3,
          title: _currentStep == 3
              ? const Text("Accomodation", style: TextStyle(fontSize: 14))
              : Text(""),
          content: _AccomodationWidget(),
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
                items: objectMission,
                value: object,
                hint: "Mission object",
                searchHint: "Select your mission object ",
                onChanged: (value) {
                  setState(() {
                    object = value;
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
                  });
                },
                isExpanded: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: pays,
                value: manager,
                hint: "Manager",
                searchHint: "Select your Manager",
                onChanged: (value) {
                  setState(() {
                    manager = value;
                  });
                },
                isExpanded: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchChoices.single(
                items: pays,
                value: partner,
                hint: "Partner",
                searchHint: "Select your partner",
                onChanged: (value) {
                  setState(() {
                    partner = value;
                  });
                },
                isExpanded: true,
              ),
            ),
            Column(
              children: [
                Text("Date de mission :"),
                Container(
                    child: Theme(
                  data: Theme.of(context).copyWith(
                      accentColor: Colors.deepPurpleAccent,
                      primaryColor: Colors.deepPurple,
                      buttonTheme: ButtonThemeData(
                        highlightColor: Colors.deepPurple,
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              secondary: Colors.purple,
                              primary: Colors.deepPurple,
                              primaryVariant: Colors.deepPurpleAccent,
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
            Padding(
              padding: const EdgeInsets.only(top: 0.8, left: 12),
              child: Text("Your Perdiem ..."),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: amount,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => val.isEmpty ? 'Entrez amount' : null,
                onChanged: (val) => amount = val,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '  Amount ',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                minLines: 2,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Comment expense',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (val) => comment = val,
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
                  setState(() async {
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
                          print(
                              "dataaaaaaaa :" + missionCite.length.toString());
                        });

                        int i = 0;
                        print("dataaaaaaaa 222 :" +
                            citeMission.length.toString());
                        missionCite.asMap().forEach((index, element) {
                          i++;
                          citeMission.add(
                            DropdownMenuItem(
                                child: Text("$i : " + element["name"]),
                                value: element),
                          );

                          //  selectedValue = User["manager"];
                        });

                        print("dataaaaaaaa 333 :" +
                            citeMission.length.toString());
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

                      visaId = missionIdCountry[0]["visa"];
                      //  print("..................." +missionIdCountry[0]["_id"].toString());

                      //  print("..................." + visaId.toString());
                      //  print("Cite length : " + missionCite.length.toString());

                      getVisa =
                          _missionService.getVisaById(visaId).then((value) {
                        setState(() async {
                          missionVisa = value["data"]["name"];
                          print("..................." + value["data"]["name"]);
                        });
                      });

                      getCite = _missionService
                          .getCiteByCountry(missionIdCountry[0]["_id"])
                          .then((value) {
                        for (var i = 0; i < missionCiteDes.length; i++) {
                          citeDesMission.removeLast();
                        }
                        setState(() {
                          missionCiteDes = value["data"];
                          print("dataaaaaaaa :" +
                              missionCiteDes.length.toString());
                        });

                        int i = 0;

                        missionCiteDes.asMap().forEach((index, element) {
                          i++;
                          citeDesMission.add(
                            DropdownMenuItem(
                                child: Text("$i : " + element["name"]),
                                value: element),
                          );

                          //  selectedValue = User["manager"];
                        });
                      });

                      getCityCap = _missionService
                          .getCityCapByCountry(missionIdCountry[0]["_id"])
                          .then((value) {
                        setState(() async {
                          Mximum_rate_per_night =
                              value["data"]["Mximum_rate_per_night"];
                          //  print("................... 111" +value["data"]["Mximum_rate_per_night"].toString());
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

                                //  selectedValue = User["manager"];
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
                        setState(() async {
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

                                //  selectedValue = User["manager"];
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

  Widget _AccomodationWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeys[3],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /*   Padding(
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

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: hotelPreference,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => val.isEmpty ? 'Entrez titel' : null,
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
                  Mximum_rate_per_night.toString()),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 12),
              child: Text("select your preferred hotel :"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 12),
              child: MapScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _visaVaccinetiWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeys[4],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                child: Theme(
              data: Theme.of(context).copyWith(
                  accentColor: Colors.deepPurpleAccent,
                  primaryColor: Colors.deepPurple,
                  buttonTheme: ButtonThemeData(
                    highlightColor: Colors.deepPurple,
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          secondary: Colors.purple,
                          primary: Colors.deepPurple,
                          primaryVariant: Colors.deepPurpleAccent,
                        ),
                  )),
              child: Column(
                children: [
                  Text("Validité du passeport :"),
                  Builder(
                      builder: (context) => TextButton.icon(
                            label: Text(
                              this.labeDatePasseport,
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
                                  this.labeDatePasseport = "From " +
                                      this.StartDate +
                                      "  To " +
                                      EndDate;
                                });
                              }
                            },
                          )),
                ],
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Visa : " + missionVisa),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Je dois obtenir le visa : "),
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("vaccine 1 : "),
                Checkbox(
                  //  hoverColor: LightColors.kDarkBlue,
                  //  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: vaccinB,
                  onChanged: (bool value) {
                    setState(() {
                      vaccinB = value;
                    });
                  },
                ),
              ],
            )

            /*    ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: vaccineMission.length,
              itemBuilder: (context, i) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(vaccineMission[i] + " : "),
                    Checkbox(
                      //  hoverColor: LightColors.kDarkBlue,
                      //  fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: vaccinB[i],
                      onChanged: (bool value) {
                        setState(() {
                          vaccinB[i] = value;
                        });
                      },
                    ),
                  ],
                );
              },
            )
     */
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

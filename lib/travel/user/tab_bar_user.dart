import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/screens/Login/SignInScreen.dart';
import 'package:vato/screens/User/list_history.dart';
import 'package:vato/screens/User/user_screen.dart';
import 'package:vato/services/DeskServices.dart';
import 'package:vato/services/OperationsService.dart';
import 'package:vato/services/ServiceLineService.dart';
import 'package:vato/services/UserServices.dart';
import 'package:vato/travel/user/historique.dart';
import 'package:vato/widgets/top_container.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Login/SignInScreen.dart';

import 'package:vato/services/DeskServices.dart';
import 'package:vato/services/ServiceLineService.dart';
import 'package:vato/services/UserServices.dart';

import 'package:vato/travel/user/profil%20travel.dart';
import 'package:vato/travel/user/vaccin_visa.dart';
import 'package:vato/widgets/top_container_travel.dart';

class TabBarUser extends StatefulWidget {
  @override
  _TabBarUserState createState() => _TabBarUserState();
}

class _TabBarUserState extends State<TabBarUser> {
  Future<SharedPreferences> _prefs;

  String firstname;

  String lastname;

  String email;

  String role;

  String passportValidity = "";

  String iduser;

  String tokenLogin;

  String spotname;

  String spotid;

  String DateDebut;

  String DateFin;

  bool visible;

  String NBRCANCEL = "0";

  String NBRCHECK = "0";

  String NBRres = "0";

  String SUBSERVICElINE = "";

  String SERVICElINE = "";

  String grade = "";

  String endFreeDate;

  String startFreeDate;

  String telephone = "";

  String mat = "";

  int _selectedIndex = 0;

  DateTime FormatStartDate = DateTime.now().add(Duration(days: 1));

  DateTime FormatSndDate = DateTime.now().add(Duration(days: -7));

  String endDate;

  String startDate;

  int nbrMissionComleted = 0;
  int nbrCurrentMission = 0;
  int nbrCanceledMission = 0;

  final DateRangePickerController _controllerRange =
      DateRangePickerController();

  UserService rs = new UserService();

  ServiceLineService Ss = new ServiceLineService();

  DeskServices _deskServices = new DeskServices();
  OperationService _operationService = new OperationService();
  List Operations = [];

  List visas = [];
  List vaccines = [];

  List missions = [];

  VoidCallback onClicked;

  String photo;

  File _imagefile;

  final picker = ImagePicker();
  Future<void> getImagegallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      if (pickedFile != null) {
        _imagefile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> getImagecamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 25);
    setState(() {
      if (pickedFile != null) {
        _imagefile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Map<String, dynamic> payload;

  Future<void> upload() async {
    String base64Image = base64Encode(_imagefile.readAsBytesSync());
    String fileName = _imagefile.path.split("/").last;

    http.post(Uri.parse(link.linkw + '/api/user/image'), body: {
      "image": base64Image,
      "name": fileName,
      "id": iduser,
    }).then((res) {
      print(res.body.toString());
    }).catchError((err) {
      print(err);
    });
  }

  Future<dynamic> getUserProfil() {
    rs.getUserProfil(iduser.toString(), tokenLogin).then((value) {
      setState(() {
        if (value["data"]["photo"] != null) {
          photo = value["data"]["photo"].toString();
        }
        if (value["data"]["role"] != null) {
          role = value["data"]["role"].toString();
        }

        if (value["data"]["visa"] != null) {
          visas = value["data"]["visa"];
        }
        if (value["data"]["passportValidity"] != null) {
          passportValidity = value["data"]["passportValidity"].substring(0, 10);

          /* String datep = value["data"]["passportValidity"].substring(0, 10);
          passportValidity = DateTime.parse(datep);

          print("******** date ********** " + passportValidity.toString());*/
        }

        if (value["data"]["vaccine"] != null) {
          vaccines = value["data"]["vaccine"];
        }
        if (value["data"]["grade"]["grade_name"] != null) {
          grade = value["data"]["grade"]["grade_name"].toString();
        }

        if (value["data"]["telephone"] != null) {
          telephone = value["data"]["telephone"].toString();
        }
        if (value["data"]["registrationNumber"] != null) {
          mat = value["data"]["registrationNumber"].toString();
        }
        if (value["data"]["subServiceLine"] != "null") {
          SUBSERVICElINE = value["data"]["subServiceLine"].toString() + "/";
        }
        if (value["data"]["spot"] != null) {
          print("sssssspoottttttttttt" + value["data"]["spot"].toString());
          setState(() {
            spotname = value["data"]["spot"]["name"].toString();
            spotid = value["data"]["spot"]["_id"].toString();
            startFreeDate = value["data"]["spot"]["startFreeDate"].toString();
            endFreeDate = value["data"]["spot"]["endFreeDate"].toString();
          });
        }
      });
    });
  }

  Future<dynamic> getProfil;
  ImageProvider decideImage() {
    if (_imagefile == null) {
      if (photo == null) {
        return AssetImage("assets/images/user3.png");
      } else {
        return NetworkImage(link.linkw + "/uploads/" + photo);
      }
    } else {
      return FileImage(_imagefile);
    }
  }

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        //  Map<String, dynamic> text = jsonDecode(prefs.get("go_user"));
        firstname = prefs.get("firstname");
        lastname = prefs.get("lastname");
        email = prefs.get("Email");
        // role = prefs.get("role");
        iduser = prefs.get("_id");
        tokenLogin = prefs.get("token");
        getProfil = getUserProfil();

        var newFormat = DateFormat("yyyy-MM-dd");
        startDate = newFormat.format(FormatStartDate);
        endDate = newFormat.format(FormatSndDate);
        visible = false;
      });
    });
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        // prefs.get("token").toString()
        this.tokenLogin = prefs.get("token").toString();
        Map<String, dynamic> payload = Jwt.parseJwt(
          this.tokenLogin.toString(),
        );
        _operationService
            .getOperationsbyUser(iduser, tokenLogin)
            .then((value) async {
          if (value["data"] != null) {
            setState(() {
              Operations = value["data"];

              DateTime today = new DateTime.now();

              nbrCanceledMission = Operations.length;
              print("object" + nbrCanceledMission.toString());
              Operations.forEach((element) async {
                missions.add(element["request"]["mission"]);
                print("ttttt" + missions.toString());

                if (today.compareTo(DateTime.parse(
                        element["request"]["mission"]["startDate"])) ==
                    1) {
                  nbrMissionComleted += 1;
                } else {
                  nbrCurrentMission += 1;
                }
              });
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: LightColors.kDarkBlue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainerTravel(
              height: height / 4,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            footer: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                              hint: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  )),
                              isExpanded: false,
                              icon: Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              onChanged: (String newValue) async {},
                              items: <String>[
                                'From Gallery',
                                'From Camera',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style:
                                        TextStyle(color: LightColors.kDarkBlue),
                                  ),
                                );
                              }).toList(),
                            )),
                            radius: height / 6.5,
                            lineWidth: 1.5,
                            animation: true,
                            percent: 0.75,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.white,
                            backgroundColor: LightColors.kDarkBlue,
                            center: CircleAvatar(
                              backgroundColor: LightColors.kLavender,
                              radius: height / 15,
                              backgroundImage:
                                  AssetImage("assets/images/10.jpeg"),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: AutoSizeText(
                                  firstname.toString() +
                                      "  " +
                                      lastname.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  maxLines: 1,
                                  maxFontSize: 25.0,
                                  minFontSize: 8,
                                ),
                              ),
                              SizedBox(
                                height: height / 70,
                              ),
                              Container(
                                margin: new EdgeInsets.only(left: 5),
                                child: AutoSizeText(
                                  email.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  maxFontSize: 20.0,
                                  minFontSize: 6,
                                ),
                              ),
                              SizedBox(
                                height: height / 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: new EdgeInsets.only(left: 90),
                                    child: AutoSizeText(
                                      "Role : ",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                      maxFontSize: 20.0,
                                      minFontSize: 6,
                                    ),
                                  ),
                                  Container(
                                    child: AutoSizeText(
                                      role.toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      maxLines: 1,
                                      maxFontSize: 20.0,
                                      minFontSize: 6,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                decoration: BoxDecoration(
                    color: NeumorphicColors.background,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                      backgroundColor: NeumorphicColors.background,
                      appBar: TabBar(
                        indicatorWeight: 2,
                        indicatorColor: LightColors.kDarkBlue,
                        tabs: [
                          Tab(
                              child: Text(
                            "Information",
                            style: TextStyle(color: Colors.black),
                          )),
                          Tab(
                              child: Text("Visas & Vaccines",
                                  style: TextStyle(color: Colors.black))),
                          Tab(
                              child: Text("Histories",
                                  style: TextStyle(color: Colors.black))),
                        ],
                      ),
                      body: TabBarView(
                        children: [
                          Profiltravel(
                              telephone,
                              grade,
                              nbrMissionComleted,
                              nbrCurrentMission,
                              mat,
                              passportValidity,
                              firstname,
                              lastname),
                          VaccinVisa(visas, vaccines),
                          Historique(missions)
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            child: Container(
                margin: EdgeInsets.all(8),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear();
              final _storage = const FlutterSecureStorage();
              await _storage.deleteAll();
              DateTime selectedDate = DateTime.now();

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SignInScreen(selectedDate)));
            },
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.all(8),
              child: Container(
                width: 30,
                height: 30,
                child: (spotname != null)
                    ? Image(
                        image: AssetImage("assets/images/parkingLogo.png"),
                      )
                    : Container(),
              ),
            ),
            onTap: () async {
              if (startFreeDate == "null" || endFreeDate == "null") {
                _openPopupFreeParking();
              } else {
                _CancelFreeParking(startFreeDate, endFreeDate);
              }
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }

  _openPopupFreeParking() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool PMVAL = false;
    bool AMVAL = false;
    void STATEPM(setState) {
      setState(() {
        PMVAL = !PMVAL;
      });
    }

    void STATEAM(setState) {
      setState(() {
        AMVAL = !AMVAL;
      });
    }

    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      backgroundColor: Colors.black12,
      titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      descStyle: TextStyle(
        color: LightColors.kbluen,
      ),
      alertAlignment: Alignment.center,
    );
    Alert(
        context: context,
        title: spotname,
        type: AlertType.none,
        style: alertStyle,
        desc: "Select a priod to free your spot",
        content: StatefulBuilder(
          builder: (context2, StateSetter setState) {
            return Container(
              width: 250,
              height: 400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    SfDateRangePicker(
                      controller: _controllerRange,
                      backgroundColor: Colors.black12,
                      view: DateRangePickerView.month,
                      minDate: DateTime.now().add(Duration(days: 1)),
                      headerStyle: DateRangePickerHeaderStyle(
                          textStyle: TextStyle(color: Colors.white)),
                      selectionColor: Colors.blue,
                      startRangeSelectionColor: NeumorphicColors.background,
                      selectionTextStyle:
                          TextStyle(color: LightColors.kDarkBlue),
                      endRangeSelectionColor: NeumorphicColors.background,
                      rangeSelectionColor: Colors.white,
                      rangeTextStyle: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18), //   todayHighlightColor: Colors.red,

                      monthCellStyle: DateRangePickerMonthCellStyle(
                        //   specialDatesTextStyle: const TextStyle(color: Colors.red) ,
                        // weekendTextStyle: const TextStyle(color: Colors.red),
                        trailingDatesDecoration: BoxDecoration(
                            color: const Color(0xFFDFDFDF),
                            border: Border.all(
                                color: const Color(0xFFB6B6B6), width: 1),
                            shape: BoxShape.circle),
                        trailingDatesTextStyle: TextStyle(color: Colors.white),
                        disabledDatesDecoration: BoxDecoration(
                            color: const Color(0xFFDFDFDF),
                            border: Border.all(
                                color: const Color(0xFFB6B6B6), width: 1),
                            shape: BoxShape.circle),
                        // disabledDatesTextStyle: const TextStyle(color: Colors.red),
                        leadingDatesDecoration: BoxDecoration(
                            color: const Color(0xFFDFDFDF),
                            border: Border.all(
                                color: const Color(0xFFB6B6B6), width: 1),
                            shape: BoxShape.circle),
                        leadingDatesTextStyle:
                            const TextStyle(color: Colors.white),
                        textStyle: const TextStyle(color: Colors.white),
                        todayCellDecoration: BoxDecoration(
                            color: const Color(0xFFDFDFDF),
                            border: Border.all(
                                color: const Color(0xFFB6B6B6), width: 1),
                            shape: BoxShape.circle),
                        //  blackoutDateTextStyle: const TextStyle(color: Colors.purple),
                        //  todayTextStyle: const TextStyle(color: Colors.green),
                      ),
                      selectionMode: DateRangePickerSelectionMode.range,
                      onSelectionChanged: selectionChangedrange,
                      monthViewSettings: DateRangePickerMonthViewSettings(
                          viewHeaderStyle: DateRangePickerViewHeaderStyle(
                              textStyle: TextStyle(color: Colors.white)),
                          enableSwipeSelection: true),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DialogButton(
                      width: width / 3,
                      color: LightColors.kDarkBlue,
                      onPressed: () async {
                        _deskServices.FreeSpot(
                                startDate, endDate, spotid, tokenLogin)
                            .then((value) {
                          Navigator.pop(context);

                          SweetAlert.show(context2,
                              subtitle: "loading ...",
                              style: SweetAlertStyle.loading);
                          new Future.delayed(new Duration(seconds: 2), () {
                            if (value["status"].toString() == "200") {
                              getUserProfil();
                              SweetAlert.show(context2,
                                  subtitle: "Done!",
                                  style: SweetAlertStyle.success);
                            } else {
                              {
                                SweetAlert.show(context2,
                                    subtitle: "Ooops! Something Went Wrong!!",
                                    style: SweetAlertStyle.error);
                              }
                            }
                          });
                        });
                      },
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ]),
            );
          },
        ),
        buttons: []).show();
  }

  _CancelFreeParking(startDate, EndDate) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool PMVAL = false;
    bool AMVAL = false;
    void STATEPM(setState) {
      setState(() {
        PMVAL = !PMVAL;
      });
    }

    void STATEAM(setState) {
      setState(() {
        AMVAL = !AMVAL;
      });
    }

    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      backgroundColor: Colors.black12,
      titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      descStyle: TextStyle(
        color: LightColors.kbluen,
      ),
      alertAlignment: Alignment.center,
    );
    Alert(
        context: context,
        title: spotname,
        type: AlertType.none,
        style: alertStyle,
        //desc: "You have freed up your parking spot from "+startDate.substring(0, 10) +" until "+EndDate.substring(0, 10)+"." ,
        content: StatefulBuilder(
          builder: (context2, StateSetter setState) {
            return Container(
              width: 250,
              height: 400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: ("You have freed up your parking spot from "),
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        TextSpan(
                            text: startDate.substring(0, 10),
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        TextSpan(
                            text: " until  ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        TextSpan(
                            text: EndDate.substring(0, 10),
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ]),
                    ),
                    DialogButton(
                      width: width / 3,
                      color: LightColors.kDarkBlue,
                      onPressed: () async {
                        _deskServices.CancelFreeSpot(spotid, tokenLogin)
                            .then((value) {
                          Navigator.pop(context);

                          SweetAlert.show(context2,
                              subtitle: "loading ...",
                              style: SweetAlertStyle.loading);
                          new Future.delayed(new Duration(seconds: 2), () {
                            if (value["status"].toString() == "200") {
                              getUserProfil();
                              SweetAlert.show(context2,
                                  subtitle: "Done!",
                                  style: SweetAlertStyle.success);
                            } else {
                              {
                                SweetAlert.show(context2,
                                    subtitle: "Ooops! Something Went Wrong!!",
                                    style: SweetAlertStyle.error);
                              }
                            }
                          });
                        });
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ]),
            );
          },
        ),
        buttons: []).show();
  }

  Widget buildImage() {
    final image = decideImage();

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 98,
          height: 98,
          child: InkWell(onTap: () {
            BottomSheet();
          }),
        ),
      ),
    );
  }

  Widget BottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('From Camera'),
              onTap: () async {
                await getImagecamera();
                await upload();

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('From Galery'),
              onTap: () async {
                await getImagegallery();
                await upload();

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void selectionChangedrange(DateRangePickerSelectionChangedArgs args) {
    PickerDateRange ranges = args.value;

    setState(() {
      startDate = ranges.startDate.toString();
      endDate = ranges.endDate.toString();
    });
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 2,
        child: buildCircle(
          color: color,
          all: 5,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    Widget child,
    double all,
    Color color,
  }) =>
      ClipOval(
        child: InkWell(
            child: Container(
              padding: EdgeInsets.all(all),
              color: color,
              child: child,
            ),
            onTap: () {
              BottomSheet();
            }),
      );
}
